import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersFirestore {

  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("orders");

  // Method to add location details to the user
  Future<void> addOrder(Map<String, dynamic> values) async {
    await _collectionReference.doc().set(values);
  }

  // Clear the users cart after they have made an order
  Future<void> clearCart(String userID) async {
    Map<String, dynamic> cart = {
      'cart': []
    };
    await FirebaseFirestore.instance.collection('users').doc(userID).set(cart);
  }
}