import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/parent_barber.dart';


class BarberFirestore {
  static const BARBERS = "barbers";
  static const PRODUCTS = "products";
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

  Future<bool> createAddBarber({String firstName, String lastName, String description, String image}) async {

    Map<String, dynamic> newBarber = {
      "firstName": firstName,
      "lastName": lastName,
      "description": description,
      "image": image,
      "rating": 0,
      "featured": false,
    };
    try {
      await  _firebaseFirestore.collection(BARBERS).doc().set(newBarber);
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