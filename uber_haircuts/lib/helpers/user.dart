import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_haircuts/models/user.dart';

class UserHelper {
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add a new user through using collection.set
  void createNewUser(Map<String, dynamic> values)  {
    String id = values["id"];
    _firestore.collection(collection).doc(values[id]).set(values);
  }

  // Method to update an existing user
  void editUser(Map<String, dynamic> values)  {
    _firestore.collection(collection).doc(values['id']).update(values);
  }

  // Fetch the user based on a given ID
  Future<UserModel> getUserById(String userId) {
    _firestore.collection(collection).doc(userId).get().then((value) {
      return UserModel.fromSnapshot(value);
    });
  }


}