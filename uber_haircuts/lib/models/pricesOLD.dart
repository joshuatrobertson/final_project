import 'package:uber_haircuts/models/product.dart';


// Class representing a barber including a list of Product classes
class Prices {
  static const ID = "id";
  static const PRICE = "price";
  static const PRODUCT = "product";
  static const FEATURED = "featured";


  int _id;
  String _price;
  Product _product;
  bool _featured;

  // Getter functions
  int get id => _id;

  String get price => _price;

  Product get product => _product;

  bool get featured => _featured;


  Prices.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _price = snapshot.data[PRICE].floor();
    _product = snapshot.data[PRODUCT];
    _featured = snapshot.data[FEATURED];

  }
}
