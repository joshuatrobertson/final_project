import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authenticate {

  FirebaseAuth _firebaseAuth;
  Authenticate(this._firebaseAuth);
  // Function to test for logged in user and return relevant page
  Stream<User> get stateChanges => _firebaseAuth.authStateChanges();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);


  Future<bool> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print("signed in " + email);
      return true;
    } catch (exception) {
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

      print("signed in " + user.displayName);
      return true;
  } catch (exception) {
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
      return true;
    } catch(e) {
      print(e);
      return false;
    }
  }

  Future<bool> twitterSignIn() async {
    try {
      final AccessToken result = await FacebookAuth.instance.login();

      final facebookAuthCredential = FacebookAuthProvider.credential(result.token);

      _firebaseAuth.signInWithCredential(facebookAuthCredential);
      return true;
    } catch(e) {
      print(e);
      return false;
    }
  }

  Future<bool> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print(email + " signed up");
      return true;
    }
    catch (exception) {
      return false;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

}