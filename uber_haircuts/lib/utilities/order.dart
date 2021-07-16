import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/cart.dart';
import 'package:uber_haircuts/models/user.dart';

class OrderUtility {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const USERS = "users";

  void addToCart({String userId, CartItem cartItem}){
    // Update the 'users' database with the new cart item
    _firestore.collection(USERS).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  Future<UserModel> getUserById(String userId) => _firestore.collection(USERS).doc(userId).get().then((value){
    return UserModel.fromSnapshot(value);
  });

}
