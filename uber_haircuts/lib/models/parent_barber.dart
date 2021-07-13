import 'package:cloud_firestore/cloud_firestore.dart';


// Class representing a barber including a list of Product classes
class ParentBarberModel {

  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const DESCRIPTION = "description";
  static const RATING = "rating";
  static const FEATURED = "featured";
  static const LOCATION_GEOHASH = "locationGeohash";

  String _id;
  String _name;
  String _image;
  String _description;
  double _rating;
  bool _featured;
  String _locationGeohash;

  String get id => _id;
  String get name => _name;
  String get image => _image;
  String get description => _description;
  double get rating => _rating;
  bool get featured => _featured;
  String get locationGeohash => _locationGeohash;

  set id(String id) => _id;
  set name(String name) => _name;
  set image(String image) => _image;
  set description(String description) => _description;
  set rating(double rating) => _rating;
  set featured(bool featured) => _featured;
  set locationGeohash(String locationGeohash) => _locationGeohash;

  ParentBarberModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.id;
    _name = documentSnapshot.data()[NAME];
    _image = documentSnapshot.data()[IMAGE];
    _description = documentSnapshot.data()[DESCRIPTION];
    _rating = documentSnapshot.data()[RATING];
    _featured = documentSnapshot.data()[FEATURED];
    _locationGeohash = documentSnapshot.data()[LOCATION_GEOHASH];
  }
}
