import 'package:uber_haircuts/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/product.dart';

class MadeOrdersModel {
  static const ID = "id";
  static const BARBER_ID = "barberID";
  static const USER_ID = "userID";
  static const COST = "cost";
  static const TIMESTAMP = "timestamp";
  static const PRODUCTS = "products";

  String _id;
  String _barberID;
  String _userID;
  num _cost;
  Timestamp _timestamp;
  List<OrderModel> _products;

  String get id => _id;
  String get barberID => _barberID;
  String get userID => _userID;
  num get cost => _cost;
  Timestamp get timestamp => _timestamp;
  List<OrderModel> get products => _products;


  // Get a map from data
  MadeOrdersModel.fromMap(Map item){
    _id = item[ID];
    _barberID =  item[BARBER_ID];
    _userID =  item[USER_ID];
    _cost =  item[COST];
    _timestamp =  item[TIMESTAMP];
    _products =  item[PRODUCTS];
  }

  MadeOrdersModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.data()[ID];
    _barberID = documentSnapshot.data()[BARBER_ID];
    _userID = documentSnapshot.data()[USER_ID];
    _cost = documentSnapshot.data()[COST];
    _timestamp = documentSnapshot.data()[TIMESTAMP];
    _products = _convertProductsFromMap(documentSnapshot.data()[PRODUCTS]);
  }

  List<OrderModel> _convertProductsFromMap(List orders) {
    List<OrderModel> _result = [];
    orders.forEach((element) {
      OrderModel cartItem = OrderModel.fromMap(element);
      _result.add(cartItem);
    });
    return _result;
  }

}
