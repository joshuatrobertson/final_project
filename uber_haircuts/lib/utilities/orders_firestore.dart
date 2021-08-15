import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersFirestore {

  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection("orders");

  // Method to add location details to the user
  void addOrder(Map<String, dynamic> values)  {
    _collectionReference.doc().set(values);
  }
}