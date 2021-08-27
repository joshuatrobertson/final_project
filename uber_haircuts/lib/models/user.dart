import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/made_orders.dart';
import 'package:uber_haircuts/models/order.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:uber_haircuts/utilities/orders_firestore.dart';

// User model to store data within firebase
class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const UID = "uid";
  static const ADDRESS = "address";
  static const CART = "cart";
  static const ORDERS = "orders";

  String _name;
  String _email;
  String _uid;
  List<OrderModel> cart;
  PlaceModel addressDetails;
  List<MadeOrdersModel> orders;

  String get name => _name;
  String get email => _email;
  String get uid => _uid;

  UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _name = documentSnapshot.data()[NAME];
    _email = documentSnapshot.data()[EMAIL];
    _uid = documentSnapshot.data()[UID];
    cart = _convertCartFromMap(documentSnapshot.data()[CART]);
    orders = _convertOrdersFromMap(documentSnapshot.data()[ORDERS]);
    addressDetails = _convertLocationDetails(documentSnapshot.data()[ADDRESS]);
  }

  UserModel();

  List<OrderModel> _convertCartFromMap(List orders) {
    List<OrderModel> _result = [];
    orders.forEach((element) {
      OrderModel cartItem = OrderModel.fromMap(element);
      _result.add(cartItem);
    });
    return _result;
  }

  List<MadeOrdersModel> _convertOrdersFromMap(List orders) {
    OrdersFirestore ordersFirestore = new OrdersFirestore();
    List<MadeOrdersModel> _result = [];
    orders.forEach((element) async {
      MadeOrdersModel item = await ordersFirestore.fetchOrder(element.toString());
      _result.add(item);
    });
    return _result;
  }

  void fromMap(Map map) {
    _name = map[NAME];
    _email =  map[EMAIL];
    _uid =  map[UID];
    cart = [];
    orders = [];
    }

  PlaceModel _convertLocationDetails(List address) =>
    new PlaceModel(number: address[0]["number"], street: address[1]["street"], city: address[2]["city"], postcode: address[3]["postcode"]);


  // Add an item to the local cart
  void addToCart(OrderModel cartItem) {
    try {
      cart.add(cartItem);
    } catch(e) {
      print("Error adding item to local cart: " + e.toString());
    }
  }

  // Remove an item from the local cart
  void removeFromCart(int index) {
    cart.removeAt(index);
  }

}