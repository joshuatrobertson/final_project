import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_haircuts/models/cart.dart';
import 'package:uber_haircuts/models/location.dart';
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
  PlaceModel locationDetails;

  String get name => _name;
  String get email => _email;
  String get uid => _uid;

  UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _name = documentSnapshot.data()[NAME];
    _email = documentSnapshot.data()[EMAIL];
    _uid = documentSnapshot.data()[UID];
    cart = _convertCartFromMap(documentSnapshot.data()[CART]);
    locationDetails = _convertLocationDetails(documentSnapshot.data()[LOCATION]);
  }

  UserModel();

  List<CartItem> _convertCartFromMap(List cart) {
    List<CartItem> _result = [];
    cart.forEach((element) {
      CartItem cartItem = CartItem.fromMap(element);
      _result.add(cartItem);
    });
    return _result;
  }

  void fromMap(Map map) {
    _name = map[NAME];
    _email =  map[EMAIL];
    _uid =  map[UID];
    cart = [];
    }

  PlaceModel _convertLocationDetails(List location) =>
      new PlaceModel(number: location[0]["number"], street: location[1]["street"], city: location[2]["city"], postcode: location[3]["postcode"]);

  void addToCart(CartItem cartItem) {
    try {
      cart.add(cartItem);
    } catch(e) {
      print("Error adding item to local cart: " + e.toString());
    }
  }

  void removeFromCart(int index) {
    cart.removeAt(index);
  }

}