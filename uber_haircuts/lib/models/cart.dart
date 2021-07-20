// Class representing a cart item to be used for the shopping cart

import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  static const ID = "id";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";

  String _id;
  String _productId;
  int _quantity;

  String get id => _id;
  String get productId => _productId;
  int get quantity => _quantity;


  // Get a map from data
  CartItem.fromMap(Map item){
    _id = item[ID];
    _productId =  item[PRODUCT_ID];
    _quantity =  item[QUANTITY];
  }

  // Create a map with json objects
  Map toMap() => {
    ID: _id,
    PRODUCT_ID: _productId,
    QUANTITY: _quantity
  };

  CartItem.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.data()[ID];
    _productId = documentSnapshot.data()[PRODUCT_ID];
    _quantity = documentSnapshot.data()[QUANTITY];
  }
}
