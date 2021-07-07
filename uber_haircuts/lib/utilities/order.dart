import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/cart.dart';
import 'package:uber_haircuts/models/user.dart';

class OrderHelper {
  FirebaseFirestore _firestore;
  String users = "users";

  void addToCart({String userId, CartItem cartItem}){
    // Update the 'users' database with the new cart item
    _firestore.collection(users).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  Future<UserModel> getUserById(String userId) => _firestore.collection(users).doc(userId).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });

}
