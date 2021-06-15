import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const ID = "id";
  static const LOCATION = "location";

  String _name;
  String _email;
  String _id;
  String _location;

  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get location => _location;

  UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _name = documentSnapshot.data()[NAME];
    _email = documentSnapshot.data()[EMAIL];
    _id = documentSnapshot.data()[ID];
    _location = documentSnapshot.data()[LOCATION];
  }
}