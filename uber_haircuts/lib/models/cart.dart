// Class representing a cart item to be used for the shopping cart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/product.dart';

class CartItem {
  static const ID = "id";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";


  String _id;
  String _productId;
  ProductModel _product;
  int _quantity;

  String get id => _id;
  String get productId => _productId;
  int get quantity => _quantity;
  ProductModel get product => _product;

  set product(ProductModel productModel) => _product = productModel;
  set quantity(int quantity) => _quantity = quantity;

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

  void updateQuantity(String quantity) {
    if(quantity == 'increase') {
      _quantity++;
    }
    else {
      _quantity--;
    }
  }

}
