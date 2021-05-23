import 'package:cloud_firestore/cloud_firestore.dart';

// Class representing a barber product
class Product {
  static const ID = "id";
  static const NAME = "name";
  static const DESCRIPTION = "description";
  static const PRICE = "price";

  int _id;
  String _name;
  String _description;
  double _price;

  // Getter functions
  int get id => _id;

  String get name => _name;

  String get description => _description;

  double get price => _price;


  // Link the data with the firebase database
  Product.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _description = snapshot.data[DESCRIPTION];
    _price = snapshot.data[PRICE];
  }
}