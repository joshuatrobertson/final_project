import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticate {

  // Create an instance of firebase and authenticate it
  FirebaseAuth _firebaseAuth;
  Authenticate(this._firebaseAuth);
  // Function to test for logged in user and return relevant page
  Stream<User> get stateChanges => _firebaseAuth.authStateChanges();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  var _twitterSignIn = new TwitterLogin(
    consumerKey: '1403651379705663488-I6gxGAkJqPrkSRXTxysm5wmI3Hc5no',
    consumerSecret: 'KVP7xVAAdZYZ5TV1xW5tQBAriXR8QOPvOxqhYc9OWi0L4',
  );


  Future<bool> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print("signed in " + email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication authentication = await account.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken
      );

      final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
      final User user = authResult.user;

      print("signed in with Google as: " + user.displayName);
      return true;
  } catch (e) {
      print(e);
      return false;
    }
  }

  Future googleSignOut() async {
    print("signed out google account");
    _googleSignIn.signOut();
  }

  Future<bool> facebookSignIn() async {
    try {
      final AccessToken result = await FacebookAuth.instance.login();

      final facebookAuthCredential = FacebookAuthProvider.credential(result.token);

      _firebaseAuth.signInWithCredential(facebookAuthCredential);
      print("Signed in with Facebook ID: " + result.userId);
      return true;
    } catch(e) {
      print(e);
      return false;
    }
  }

  Future<bool> twitterSignIn(String token, String secret) async {
      final AuthCredential credential = TwitterAuthProvider.credential(
          accessToken: token,
          secret: secret
      );
      await _firebaseAuth.signInWithCredential(credential);
    }


  Future<bool> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print(email + " signed up");
      return true;
    }
    catch (e) {
      print(e);
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

    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

}