import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_haircuts/models/cart.dart';
import 'package:uber_haircuts/models/product.dart';

// User model to store data within firebase
class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const UID = "uid";
  static const LOCATION = "location";
  static const CART = "cart";

  String _name;
  String _email;
  String _uid;
  List<CartItem> cart;

  String get name => _name;
  String get email => _email;
  String get uid => _uid;

  set name(String name) => _name;
  set email(String email) => _email;
  set uid(String uid) => _uid;


  UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _name = documentSnapshot.data()[NAME];
    _email = documentSnapshot.data()[EMAIL];
    _uid = documentSnapshot.data()[UID];
    cart = _convertFromMap(documentSnapshot.data()[CART]);
  }

  List<CartItem> _convertFromMap(List cart) {
    List<CartItem> _result = [];
    cart.forEach((element) {
      CartItem cartItem = CartItem.fromMap(element);
      _result.add(cartItem);
    });

    return _result;
  }
}