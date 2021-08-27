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
  static const APPROVED = "approved";
  static const ADDRESS = "address";
  static const BARBERS = "barbers";

  String _id;
  String _name;
  String _email;
  String _image;
  String _description;
  num _rating;
  bool _featured;
  // TODO: discuss approved boolean value and why it isn't implemented now (in test mode)
  bool _approved;
  PlaceModel address;
  List<String> _barbers;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get image => _image;
  String get description => _description;
  num get rating => _rating;
  bool get featured => _featured;
  bool get approved => _approved;
  List<String> get barbers => _barbers;

  ParentBarberModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.id;
    _name = documentSnapshot.data()[NAME];
    _email = documentSnapshot.data()[EMAIL];
    _image = documentSnapshot.data()[IMAGE];
    _description = documentSnapshot.data()[DESCRIPTION];
    _rating = documentSnapshot.data()[RATING];
    _featured = documentSnapshot.data()[FEATURED];
    address = _convertLocationDetails(documentSnapshot.data()[ADDRESS]);
    _barbers = List.from(documentSnapshot.data()[BARBERS]);
  }

  ParentBarberModel();

  PlaceModel _convertLocationDetails(List location) =>
      new PlaceModel(number: location[0]["number"], street: location[1]["street"], city: location[2]["city"], postcode: location[3]["postcode"]);

}
