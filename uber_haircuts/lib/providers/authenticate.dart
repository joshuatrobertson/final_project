import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uber_haircuts/models/cart.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:uber_haircuts/models/user.dart';
import 'package:uber_haircuts/utilities/parent_barber_firestore.dart';
import 'package:uber_haircuts/utilities/order.dart';
import 'package:uber_haircuts/utilities/user_firestore.dart';

enum AuthStatus {
  UNINITIALISED,
  UNAUTHORISED_USER,
  UNAUTHORISED_BARBER,
  NOT_AUTHENTICATED,
  AUTHENTICATING,
  AUTHENTICATED,
  BARBER_AUTHENTICATED,
  AUTH_WITH_MAPS
}

enum CurrentUser {
  CUSTOMER,
  BARBER
}

class Authenticate extends ChangeNotifier {

  bool firstOrder = true;
  CurrentUser _currentUser;
  // Create an instance of firebase and authenticate it
  FirebaseAuth _firebaseAuth;
  OrderUtility _orderUtility = new OrderUtility();
  User _user;
  UserModel userModel = new UserModel();
  ParentBarberModel barberModel = new ParentBarberModel();
  UserFirestore _userDatabase = UserFirestore();
  ParentBarberFirestore _barberFirestore = ParentBarberFirestore();
  AuthStatus _authStatus = AuthStatus.UNINITIALISED;
  // Function to test for logged in user and return relevant page
  Stream<User> get stateChanges => _firebaseAuth.authStateChanges();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  var _twitterSignIn = new TwitterLogin(
    consumerKey: '1403651379705663488-I6gxGAkJqPrkSRXTxysm5wmI3Hc5no',
    consumerSecret: 'KVP7xVAAdZYZ5TV1xW5tQBAriXR8QOPvOxqhYc9OWi0L4',
  );
  Authenticate(this._firebaseAuth);

  // Getters
  AuthStatus get authStatus => _authStatus;
  CurrentUser get currentUser => _currentUser;
  User get user => _user;
  Stream<User> get userStateChanges => _firebaseAuth.authStateChanges();

  Future<bool> signIn({String email, String password}) async {
    try {
      _authStatus = AuthStatus.AUTHENTICATING;
      notifyListeners();
      final UserCredential _authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print("signed in " + email);
      userModel = await _orderUtility.getUserById(_firebaseAuth.currentUser.uid);
      List<CartModel> orders = [];
      orders = await _orderUtility.getDatabaseCartItems(_authResult.user.uid);
      userModel.cart = orders;
      _authStatus = AuthStatus.AUTH_WITH_MAPS;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      _authStatus = AuthStatus.NOT_AUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  Future<bool> barberSignIn({String email, String password}) async {
    try {
      _authStatus = AuthStatus.AUTHENTICATING;
      notifyListeners();
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      barberModel = await _orderUtility.getBarberById(_firebaseAuth.currentUser.uid);
      _authStatus = AuthStatus.BARBER_AUTHENTICATED;
      print("signed in barber " + email);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in barber with exception: ' + e.toString());
      _authStatus = AuthStatus.NOT_AUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  void resetAuthStatus() {
    _authStatus = AuthStatus.UNINITIALISED;
    notifyListeners();
  }

  void chooseUser(String user) {
    if (user == 'user') {
      _authStatus = AuthStatus.UNAUTHORISED_USER;
      _currentUser = CurrentUser.CUSTOMER;
      notifyListeners();
    }
    else {
      _authStatus = AuthStatus.UNAUTHORISED_BARBER;
      _currentUser = CurrentUser.BARBER;
      notifyListeners();
    }
  }

  Future<bool> googleSignIn() async {
    try {
      _authStatus = AuthStatus.AUTHENTICATING;
      notifyListeners();
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication authentication = await account.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken
      );
      final UserCredential _authResult = await _firebaseAuth.signInWithCredential(credential);
      User user = await signInCreateUser(_authResult);
      print("signed in with Google as: " + user.displayName);
      notifyListeners();
      return true;
  } catch (e) {
      print(e);
      _authStatus = AuthStatus.NOT_AUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  Future<User> signInCreateUser(UserCredential _authResult) async {
    final User user = _authResult.user;
    bool userExists = await _userDatabase.checkUserExists(user.uid);
    if (!userExists) {
      // Create a map with the details given to create a user to store in the database
      Map<String, dynamic> newUser = {
        "uid": _authResult.user.uid,
        "name": _authResult.user.displayName,
        "location": [],
        "email": _authResult.user.email,
        "cart": [],
      };
    
      userModel.fromMap(newUser);
      // Create a new user and add to the database
      // Here we use the auth result user id as the document id so that it can be referred to later
      _userDatabase.createNewUser(newUser, _authResult.user.uid);
      UserModel newModel;
      this.userModel = newModel;
      _authStatus = AuthStatus.AUTHENTICATED;
      notifyListeners();
    }
    else {
      userModel = await _orderUtility.getUserById(_firebaseAuth.currentUser.uid);
      List<CartModel> orders = [];
      orders = await _orderUtility.getDatabaseCartItems(_authResult.user.uid);
      userModel.cart = orders;
      _authStatus = AuthStatus.AUTH_WITH_MAPS;
      notifyListeners();
    }
    return user;
  }

  // Turn the location values into a JSON format map to store in firebase
  Map<String, dynamic> createLocationMap(PlaceModel placeModel) {
    Map<String, dynamic> location = {
      "address": [
        {"number": placeModel.number},
        {"street": placeModel.street},
        {"city": placeModel.city},
        {"postcode": placeModel.postcode},
      ]
    };
    print("Authenticated with maps");
    _authStatus = AuthStatus.AUTH_WITH_MAPS;
    notifyListeners();
    return location;
  }

  Future<bool> facebookSignIn() async {
    try {
      _authStatus = AuthStatus.AUTHENTICATING;
      notifyListeners();
      final AccessToken result = await FacebookAuth.instance.login();
      final facebookAuthCredential = FacebookAuthProvider.credential(result.token);
      final UserCredential _authResult = await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      await signInCreateUser(_authResult);
      print("Signed in with Facebook ID: " + result.userId);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      _authStatus = AuthStatus.NOT_AUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  // Method to sign in a user via twitter
  Future<void> twitterSignIn(String token, String secret) async {
    try {
      _authStatus = AuthStatus.AUTHENTICATING;
      notifyListeners();
      final AuthCredential credential = TwitterAuthProvider.credential(
            accessToken: token,
            secret: secret
        );
      final UserCredential _authResult = await _firebaseAuth.signInWithCredential(credential);
      await signInCreateUser(_authResult);
      print("Signed in with Twitter ID: " + _authResult.user.uid);
      notifyListeners();
      return true;
    } catch (e) {
    print(e);
    _authStatus = AuthStatus.NOT_AUTHENTICATED;
    notifyListeners();
    return false;
    }
  }

  // Method to sign a user up. Creates a Map<String, dynamic> to pass through the values to the method createNewUser which then
  // adds these items to the firebase database.
  Future<bool> signUp({String name, String email, String password}) async {
    try {
      UserCredential _authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      // Update the display name so it can be fetched and used
      _firebaseAuth.currentUser.updateDisplayName(name);
      Map<String, dynamic> newUser = {
        "uid": _authResult.user.uid,
        "name": name,
        "address": [],
        "email": email,
        "cart": [],
      };
      // Create a new user and add to the database
      // Here we use the auth result user id as the document id so that it can be referred to later
      _userDatabase.createNewUser(newUser, _authResult.user.uid);
      _authStatus = AuthStatus.AUTHENTICATED;
      notifyListeners();
      print(email + " signed up");
      return true;
    }
    on FirebaseAuthException catch (e) {
      print(e);
      _authStatus = AuthStatus.NOT_AUTHENTICATED;
      notifyListeners();
      return false;
    }
  }


  Future<bool> parentBarberSignUp({String name, String description, String email, String password, String image}) async {
    try {
      UserCredential _authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      // Update the display name so it can be fetched and used
      _firebaseAuth.currentUser.updateDisplayName(name);
      Map<String, dynamic> newBarber = {
        "uid": _authResult.user.uid,
        "name": name,
        "description": description,
        "image": image,
        "email": email,
        "rating": 0,
        "featured": false,
      };
      // Create a new user and add to the database
      // Here we use the auth result user id as the document id so that it can be referred to later
      _barberFirestore.createNewParentBarber(newBarber, _authResult.user.uid);
      _authStatus = AuthStatus.BARBER_AUTHENTICATED;
      notifyListeners();
      print(email + " signed up");
      return true;
    }
    on FirebaseAuthException catch (e) {
      print(e);
      _authStatus = AuthStatus.NOT_AUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  // Method to send a password reset to the user given their specified email
  Future resetPassword(String email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error);
    }
  }
  
  Future googleSignOut() async {
    print("signed out google account");
    _googleSignIn.signOut();
  }
  
  // Sign out of all providers and then from firebase
  // TODO: sign out not working when log in from fresh install
  Future signOut() async {
    try {
      final User user = FirebaseAuth.instance.currentUser;
      _orderUtility.updateCartFirestore(userId: user.uid);
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      await _twitterSignIn.logOut();
      await _firebaseAuth.signOut();
      print("User signed out");
      _authStatus = AuthStatus.UNAUTHORISED_USER;
      notifyListeners();

    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  // Used to add an item to each user, which has their own 'Authenticate' instance
  Future addItemToCart({ProductModel productModel, int quantity}) async {

    OrderUtility _orderUtility = new OrderUtility();
    bool alreadyInCart = false;
    if (firstOrder) {
      userModel = await _orderUtility.getUserById(_firebaseAuth.currentUser.uid);
      firstOrder = false;
    }

    try {
      // Get the current user from the database
      // Generate a unique key for each cart item
      var key = UniqueKey();
      // Create a map using the relevant json objects from productModel
      Map cartItem = {
        "id": key.toString(),
        "productId": productModel.id.toString(),
        "quantity": quantity,
      };
      CartModel item = CartModel.fromMap(cartItem);
      

      userModel.cart.forEach((element) {
        if (element.productID == productModel.id) {
          alreadyInCart = true;
          return;
        }
      });
      if (!alreadyInCart) {
        item.product = productModel;
        userModel.addToCart(item);
      }
      else {
        print("Item is already in the cart");
      }
      _orderUtility.addToCart(userId: userModel.uid, cartItem: item);
    }
    catch(e) {
      print("Cart error: " + e.toString());
    }
  }

}