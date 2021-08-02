import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/parent_barber.dart';


class BarberFirestore {
  static const BARBERS = "parentBarber";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Method to add a new user through using collection.set
  void createNewBarber(Map<String, dynamic> values, String userId)  {
    _firebaseFirestore.collection(BARBERS).doc(userId).set(values);
  }

  // Method to update an existing user
  void editUser(Map<String, dynamic> values)  {
    String id = values["uid"];
    _firebaseFirestore.collection(BARBERS).doc(values[id]).update(values);
  }

  // Fetch the user based on a given ID
  Future<ParentBarberModel> getBarberById(String barberId) {
    _firebaseFirestore.collection(BARBERS).doc(barberId).get().then((value) {
      return ParentBarberModel.fromSnapshot(value);
    });
  }

  // Fetch the user based on a given ID
  ParentBarberModel getSingleBarberById(String barberId) {
    _firebaseFirestore.collection(BARBERS).doc(barberId).get().then((value) {
      return ParentBarberModel.fromSnapshot(value);
    });
  }

  Future<dynamic> checkBarberExists(String barberId) async {
    DocumentSnapshot snapshot = await _firebaseFirestore.collection(BARBERS).doc(barberId).get();
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