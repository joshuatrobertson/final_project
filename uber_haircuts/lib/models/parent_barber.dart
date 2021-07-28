import 'package:cloud_firestore/cloud_firestore.dart';


// Class representing a barber including a list of Product classes
class ParentBarberModel {

  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const DESCRIPTION = "description";
  static const RATING = "rating";
  static const FEATURED = "featured";

  String _id;
  String _name;
  String _image;
  String _description;
  double _rating;
  bool _featured;

  String get id => _id;
  String get name => _name;
  String get image => _image;
  String get description => _description;
  double get rating => _rating;
  bool get featured => _featured;



  ParentBarberModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.id;
    _name = documentSnapshot.data()[NAME];
    _image = documentSnapshot.data()[IMAGE];
    _description = documentSnapshot.data()[DESCRIPTION];
    _rating = documentSnapshot.data()[RATING];
    _featured = documentSnapshot.data()[FEATURED];
  }
}
