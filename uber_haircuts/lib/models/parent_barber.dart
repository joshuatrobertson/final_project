import 'package:cloud_firestore/cloud_firestore.dart';

import 'location.dart';


// Class representing a barber including a list of Product classes
class ParentBarberModel {

  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const IMAGE = "image";
  static const DESCRIPTION = "description";
  static const RATING = "rating";
  static const FEATURED = "featured";
  static const ADDRESS = "address";

  String _id;
  String _name;
  String _email;
  String _image;
  String _description;
  double _rating;
  bool _featured;
  PlaceModel address;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get image => _image;
  String get description => _description;
  double get rating => _rating;
  bool get featured => _featured;

  ParentBarberModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.id;
    _name = documentSnapshot.data()[NAME];
    _email = documentSnapshot.data()[EMAIL];
    _image = documentSnapshot.data()[IMAGE];
    _description = documentSnapshot.data()[DESCRIPTION];
    _rating = documentSnapshot.data()[RATING];
    _featured = documentSnapshot.data()[FEATURED];
  }

}
