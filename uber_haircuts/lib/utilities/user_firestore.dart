import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:uber_haircuts/models/user.dart';


class UserFirestore {
  static const USERS = "users";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Method to add a new user through using collection.set
  void createNewUser(Map<String, dynamic> values, String userId)  {
    _firebaseFirestore.collection(USERS).doc(userId).set(values);
  }

  // Method to update an existing user
  void editUser(Map<String, dynamic> values)  {
    String id = values["uid"];
    _firebaseFirestore.collection(USERS).doc(values[id]).update(values);
  }

  // Fetch the user based on a given ID
  Future<UserModel> getUserById(String userId) {
    _firebaseFirestore.collection(USERS).doc(userId).get().then((value) {
      return UserModel.fromSnapshot(value);
    });
  }

  void updateAddress(Map<String, dynamic> address, String userId) {
    _firebaseFirestore.collection(USERS).doc(userId).update(address);
  }

  // Fetch the user based on a given ID
  UserModel getSingleUserById(String userId) {
    _firebaseFirestore.collection(USERS).doc(userId).get().then((value) {
      return UserModel.fromSnapshot(value);
    });
  }

  // Method to add location details to the user
  void addLocationDetails(Map<String, dynamic> values, String userId)  {
    _firebaseFirestore.collection(USERS).doc(userId).update(values);
  }

  Future<dynamic> checkUserExists(String userId) async {
    DocumentSnapshot snapshot = await _firebaseFirestore.collection(USERS).doc(userId).get();

    if (snapshot == null || !snapshot.exists) {
      print("User does not exist");
      return false;
    }
    else {
      print("User exists");
      return true;
    }
  }

}