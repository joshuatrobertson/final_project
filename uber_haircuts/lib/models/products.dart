import 'package:cloud_firestore/cloud_firestore.dart';

// Class representing a barber product
class Product {
  static const ID = "id";
  static const NAME = "name";
  static const PRICE = "price";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";


  String _id;
  String _name;
  String _category;
  String _description;
  double _rating;
  int _price;
  int _rates;
  bool _featured;

  // Getter functions
  String get id => _id;

  String get name => _name;

  String get category => _category;

  String get description => _description;

  double get rating => _rating;

  int get price => _price;

  bool get featured => _featured;

  int get rates => _rates;

  // public variable
  bool liked = false;

  // Link the data with the firebase database
  Product.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _description = snapshot.data[DESCRIPTION];
    _id = snapshot.data[ID];
    _featured = snapshot.data[FEATURED];
    _price = snapshot.data[PRICE].floor();
    _category = snapshot.data[CATEGORY];
    _rating = snapshot.data[RATING];
    _rates = snapshot.data[RATES];
    _name = snapshot.data[NAME];
  }
}