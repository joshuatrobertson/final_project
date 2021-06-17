// Class representing a barber product
import 'package:cloud_firestore/cloud_firestore.dart';

enum allowedProducts {
  HAIRCUT,
  SHAVE,
  STUDENT_CUT,
}

class ProductModel {

  static const ID = "id";
  static const NAME = "name";
  static const DESCRIPTION = "id";
  static const PRICE = "price";
  static const IMAGE = "image";
  static const FEATURED = "featured";
  static const PARENT_BARBER = "parent_barber";


  String _id;
  String _name;
  String _description;
  double _price;
  String _image;
  bool _featured;
  String _parentBarber;

  String get id => _id;
  String get name => _name;
  String get description => _description;
  double get price => _price;
  String get image => _image;
  bool get featured => _featured;
  String get parentBarber => _parentBarber;

  set id(String id) => _id;
  set name(String name) => _name;
  set description(String description) => _description;
  set price(double price) => _price;
  set image(String image) => _image;
  set featured(bool featured) => _featured;
  set parentBarber(String parentBarber) => _parentBarber;

  ProductModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.data()[ID];
    _name = documentSnapshot.data()[NAME];
    _description = documentSnapshot.data()[DESCRIPTION];
    _price = documentSnapshot.data()[PRICE];
    _image = documentSnapshot.data()[IMAGE];
    _featured = documentSnapshot.data()[FEATURED];
    _parentBarber = documentSnapshot.data()[PARENT_BARBER];
  }
}