import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/made_orders.dart';
import 'package:uber_haircuts/models/order.dart';
import 'package:uuid/uuid.dart';

class OrdersFirestore {

  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("orders");
  final CollectionReference _collectionReferenceUsers = FirebaseFirestore.instance.collection("users");
  final CollectionReference _collectionReferenceBarbers = FirebaseFirestore.instance.collection("barbers");

  // Method to add location details to the user
  Future<String> addOrder(Map<String, dynamic> values) async {
    final docID = Uuid().v4();
    await _collectionReference.doc(docID).set(values);
    return docID;
  }

  // Clear the users cart after they have made an order
  Future<void> clearCart(String userID) async {
    Map<String, dynamic> cart = {
      'cart': []
    };
    await FirebaseFirestore.instance.collection('users').doc(userID).update(cart);
  }

  Future<MadeOrdersModel> fetchOrder(String orderID) async {
    var order = await _collectionReference.doc(orderID).get();
    MadeOrdersModel newOrder = MadeOrdersModel.fromSnapshot(order);
    return newOrder;
  }

  // Add the order id to both the parent barber and user
  Future<void> addOrderIDs(String userID, String barberID, String orderID) {
    _collectionReferenceUsers.doc(userID).update({
      'orders':FieldValue.arrayUnion([orderID])
    });
    _collectionReferenceBarbers.doc(barberID).update({
      'orders':FieldValue.arrayUnion([orderID])
    });

  }
}