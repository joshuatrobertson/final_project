import 'package:firebase_auth/firebase_auth.dart';

class Authenticate {

  final FirebaseAuth _firebaseAuth;

  Authenticate(this._firebaseAuth);

  // Function to test for logged in user and return relevant page
  Stream<User> get stateChanges => _firebaseAuth.authStateChanges();

  Future<bool> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (exception) {
      return false;
    }
  }

  Future<bool> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
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