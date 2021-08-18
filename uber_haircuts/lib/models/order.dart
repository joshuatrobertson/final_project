// Class representing an order item to be used for the shopping cart and orders

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/product.dart';

class OrderModel {
  static const ID = "id";
  static const PRODUCT_ID = "productID";
  static const QUANTITY = "quantity";


  String _id;
  String _productID;
  ProductModel _product;
  int _quantity;

  String get id => _id;
  String get productID => _productID;
  int get quantity => _quantity;
  ProductModel get product => _product;

  set product(ProductModel productModel) => _product = productModel;
  set quantity(int quantity) => _quantity = quantity;

  // Get a map from data
  OrderModel.fromMap(Map item){
    _id = item[ID];
    _productID =  item[PRODUCT_ID];
    _quantity =  item[QUANTITY];
  }

  // Create a map with json objects
  Map toMap() => {
    ID: _id,
    PRODUCT_ID: _productID,
    QUANTITY: _quantity
  };

  OrderModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.data()[ID];
    _productID = documentSnapshot.data()[PRODUCT_ID];
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
