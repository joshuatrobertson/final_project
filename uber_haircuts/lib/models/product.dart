// Class representing a barber product
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {

  static const ID = "id";
  static const NAME = "name";
  static const DESCRIPTION = "id";
  static const IMAGE = "image";
  static const FEATURED = "featured";

  String _id;
  String _name;
  String _description;
  String _image;
  bool _featured;

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get image => _image;
  bool get featured => _featured;

  set id(String id) => _id;
  set name(String name) => _name;
  set description(String description) => _description;
  set image(String image) => _image;
  set featured(bool featured) => _featured;

  ProductModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.data()[ID];
    _name = documentSnapshot.data()[NAME];
    _description = documentSnapshot.data()[DESCRIPTION];
    _image = documentSnapshot.data()[IMAGE];
    _featured = documentSnapshot.data()[FEATURED];
  }
}