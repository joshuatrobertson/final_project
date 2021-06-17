import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/order.dart';
import 'package:uber_haircuts/models/product.dart';


// Class representing a barber including a list of Product classes
class BarberModel {

  static const ID = "id";
  static const FIRST_NAME = "firstName";
  static const LAST_NAME = "lastName";
  static const IMAGE = "image";
  static const DESCRIPTION = "description";
  static const PARENT_BARBER = "parentBarber";
  static const RATING = "rating";
  static const FEATURED = "featured";
  static const AVAILABLE_NOW = "availableNow";
  static const BARBER_PRODUCTS = "barberProducts";

  String _id;
  String _firstName;
  String _lastName;
  String _image;
  String _description;
  String _parentBarber;
  double _rating;
  bool _featured;
  bool _availableNow;
  List<ProductModel> _barberProducts;

  String get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get image => _image;
  String get description => _description;
  String get parentBarber => _parentBarber;
  double get rating => _rating;
  bool get featured => _featured;
  bool get availableNow => _availableNow;
  List<ProductModel> get barberProducts => _barberProducts;

  set id(String id) => _id;
  set firstName(String firstName) => _firstName;
  set lastName(String lastName) => _lastName;
  set image(String image) => _image;
  set description(String description) => _description;
  set parentBarber(String name) => _parentBarber;
  set rating(double rating) => _rating;
  set featured(bool featured) => _featured;
  set availableNow(bool available) => _availableNow;
  set barberProducts(List<ProductModel> products) => _barberProducts;

  BarberModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.data()[ID];
    _firstName = documentSnapshot.data()[FIRST_NAME];
    _lastName = documentSnapshot.data()[LAST_NAME];
    _image = documentSnapshot.data()[IMAGE];
    _description = documentSnapshot.data()[DESCRIPTION];
    _parentBarber = documentSnapshot.data()[PARENT_BARBER];
    _rating = documentSnapshot.data()[RATING];
    _featured = documentSnapshot.data()[FEATURED];
    _availableNow = documentSnapshot.data()[AVAILABLE_NOW];
    _barberProducts = documentSnapshot.data()[BARBER_PRODUCTS];
  }
}
