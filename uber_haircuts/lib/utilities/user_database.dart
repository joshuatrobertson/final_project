import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:uber_haircuts/models/user.dart';

class UserDatabase {
  String collection = "users";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Method to add a new user through using collection.set
  void createNewUser(Map<String, dynamic> values, String uid)  {
    _firebaseFirestore.collection(collection).doc(uid).set(values);
  }

  // Method to update an existing user
  void editUser(Map<String, dynamic> values)  {
    String id = values["uid"];
    _firebaseFirestore.collection(collection).doc(values[id]).update(values);
  }

  // Fetch the user based on a given ID
  Future<UserModel> getUserById(String userId) {
    _firebaseFirestore.collection(collection).doc(userId).get().then((value) {
      return UserModel.fromSnapshot(value);
    });
  }

  // Fetch the user based on a given ID
  UserModel getSingleUserById(String userId) {
    _firebaseFirestore.collection(collection).doc(userId).get().then((value) {
      return UserModel.fromSnapshot(value);
    });
  }

  // Method to update an existing user
  void addLocationDetails(Map<String, dynamic> values, String uid)  {
    _firebaseFirestore.collection(collection).doc(values[uid]).collection("address").add(values);
  }

}