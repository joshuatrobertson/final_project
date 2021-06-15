import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/helpers/user_database.dart';
import 'package:uber_haircuts/models/user.dart';

enum AuthStatus {
UNINITIALISED,
NOT_AUTHENTICATED,
AUTHENTICATING,
AUTHENTICATED,
AUTH_WITH_MAPS,
}

class Authenticate extends ChangeNotifier {

  // Create an instance of firebase and authenticate it
  FirebaseAuth _firebaseAuth;
  User _user;
  UserModel _userModel;
  UserDatabase _userDatabase = UserDatabase();
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
  User get user => _user;
  Stream<User> get userStateChanges => _firebaseAuth.authStateChanges();

  Future<bool> signIn({String email, String password}) async {
    try {
      _authStatus = AuthStatus.AUTHENTICATING;
      notifyListeners();
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print("signed in " + email);
      _authStatus = AuthStatus.AUTHENTICATED;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      _authStatus = AuthStatus.NOT_AUTHENTICATED;
      return false;
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
      final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
      final User user = authResult.user;
      print("signed in with Google as: " + user.displayName);
      _authStatus = AuthStatus.AUTHENTICATED;
      notifyListeners();
      return true;
  } catch (e) {
      print(e);
      _authStatus = AuthStatus.NOT_AUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  Future googleSignOut() async {
    print("signed out google account");
    _googleSignIn.signOut();
  }

  Future<bool> facebookSignIn() async {
    try {
      _authStatus = AuthStatus.AUTHENTICATING;
      final AccessToken result = await FacebookAuth.instance.login();
      final facebookAuthCredential = FacebookAuthProvider.credential(result.token);
      _firebaseAuth.signInWithCredential(facebookAuthCredential);
      print("Signed in with Facebook ID: " + result.userId);
      _authStatus = AuthStatus.AUTHENTICATED;
      notifyListeners();
      return true;

    } catch(e) {
      print(e);
      _authStatus = AuthStatus.NOT_AUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  // Method to sign in a user via twitter
  Future<bool> twitterSignIn(String token, String secret) async {
    _authStatus = AuthStatus.AUTHENTICATING;
    notifyListeners();
    final AuthCredential credential = TwitterAuthProvider.credential(
          accessToken: token,
          secret: secret
      );
      await _firebaseAuth.signInWithCredential(credential);
      _authStatus = AuthStatus.AUTHENTICATED;
    notifyListeners();
  }

  // Method to sign a user up. Creates a Map<String, dynamic> to pass through the values to the method createNewUser which then
  // adds these items to the firebase database.
  Future<bool> signUp({String name, String email, String password}) async {
    try {
      UserCredential _authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      Map<String, dynamic> newUser = {
        "id": _authResult.user.uid,
        "name": name,
        "email": email,
        "location": null
      };
      _userDatabase.createNewUser(newUser);
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

  Future resetPassword(String email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error);
    }
  }

  // Sign out of all providers and then from firebase
  Future signOut() async {
    try {
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      await _twitterSignIn.logOut();
      await _firebaseAuth.signOut();
      print("User signed out");
      _authStatus = AuthStatus.UNINITIALISED;
      notifyListeners();

    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

}