import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/product.dart';


// Class representing a barber including a list of Product classes
class OrderModel {

  static const ID = "id";
  static const PRICE = "price";
  static const PRODUCT = "product";
  static const FEATURED = "featured";

  String _id;
  double _price;
  ProductModel _product;
  bool _featured;

  String get id => _id;
  double get price => _price;
  ProductModel get product => _product;
  bool get featured => _featured;

  set id(String id) => _id;
  set price(double price) => _price;
  set product(ProductModel product) => _product;
  set featured(bool featured) => _featured;

  OrderModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.data()[ID];
    _price = documentSnapshot.data()[PRICE];
    _product = documentSnapshot.data()[PRODUCT];
    _featured = documentSnapshot.data()[FEATURED];
  }
}
