import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/parent_barber.dart';


class BarberFirestore {
  static const BARBERS = "barbers";
  static const PRODUCTS = "products";
  static const PARENT_BARBERS = "parentBarber";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Method to update an existing user
  void editBarber(Map<String, dynamic> values)  {
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

  List<BarberModel> getBarbersWithParentID(String parentID) {

  }

  Future<bool> createAddBarber({String id, String firstName, String lastName, String description, String image, String parentBarberID}) async {
    List<String> barbers = [];
    Map<String, dynamic> newBarber = {
      "firstName": firstName,
      "lastName": lastName,
      "description": description,
      "image": image,
      "rating": 0,
      "featured": false,
    };
    try {
      barbers.add(id);
      await  _firebaseFirestore.collection(BARBERS).doc(id).set(newBarber);
      await _firebaseFirestore.collection(PARENT_BARBERS).doc(parentBarberID).update({
          "barbers": FieldValue.arrayUnion(barbers)
      });
      return true;
    } catch(e) {
      print("Error with adding barber: " + e.toString());
      return false;
    }
  }


  // TODO: get barber product
  Future<bool> addProduct({String barberId, String name, String description, String image, num price}) async {
    Map<String, dynamic> products = {
      "barberId": barberId,
      "name": name,
      "description": description,
      "image": image,
      "price": price,
      "featured": false,
    };
    try {
      await _firebaseFirestore.collection(PRODUCTS).doc().set(products);
      return true;
    } catch(e) {
      print("Error adding product: " + e.toString());
      return false;
    }
  }


}