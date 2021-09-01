import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/parent_barber.dart';


class ParentBarberFirestore {
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('parentBarber');

  // Method to add a new user through using collection.set
  void createNewParentBarber(Map<String, dynamic> values, String userId)  {
    _collectionReference.doc(userId).set(values);
  }

  // Method to update an existing user
  void editUser(Map<String, dynamic> values)  {
    String id = values["uid"];
    _collectionReference.doc(values[id]).update(values);
  }

  // Fetch the user based on a given ID
  Future<ParentBarberModel> getBarberById(String barberId) async {
    await _collectionReference.doc(barberId).get().then((value) {
      return ParentBarberModel.fromSnapshot(value);
    });
  }

  // Method to add location details to the user
  void addLocationDetails(Map<String, dynamic> values, String barberId)  {
    _collectionReference.doc(barberId).update(values);
  }

  // Fetch the user based on a given ID
  ParentBarberModel getSingleBarberById(String barberId) {
    _collectionReference.doc(barberId).get().then((value) {
      return ParentBarberModel.fromSnapshot(value);
    });
  }

  Future<dynamic> checkBarberExists(String barberId) async {
    DocumentSnapshot snapshot = await _collectionReference.doc(barberId).get();
    if (snapshot == null || !snapshot.exists) {
      print("Barber does not exist");
      return false;
    }
    else {
      print("Barber exists");
      return true;
    }
  }

}