import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/order.dart';
import 'package:uber_haircuts/models/location.dart';

// User model to store data within firebase
class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const UID = "uid";
  static const LOCATION = "location";
  static const CART = "cart";
  static const ORDERS = "orders";

  String _name;
  String _email;
  String _uid;
  List<OrderModel> cart;
  PlaceModel locationDetails;
  List<OrderModel> orders;

  String get name => _name;
  String get email => _email;
  String get uid => _uid;

  UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _name = documentSnapshot.data()[NAME];
    _email = documentSnapshot.data()[EMAIL];
    _uid = documentSnapshot.data()[UID];
    cart = _convertOrderFromMap(documentSnapshot.data()[CART]);
    orders = _convertOrderFromMap(documentSnapshot.data()[ORDERS]);
    locationDetails = _convertLocationDetails(documentSnapshot.data()[LOCATION]);
  }

  UserModel();

  List<OrderModel> _convertOrderFromMap(List orders) {
    List<OrderModel> _result = [];
    orders.forEach((element) {
      OrderModel cartItem = OrderModel.fromMap(element);
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

  // Add to the local orders array
  void addToOrders(OrderModel order) {
    try {
      orders.add(order);
    } catch(e) {
      print("Error adding item to local orders: " + e.toString());
    }
  }

}