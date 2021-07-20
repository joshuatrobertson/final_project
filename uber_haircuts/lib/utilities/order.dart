import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/cart.dart';
import 'package:uber_haircuts/models/user.dart';

class OrderUtility {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const USERS = "users";

  Future<void> addToCart({String userId, CartItem cartItem}) async {

    final DocumentSnapshot snapshot = await _firestore.collection(USERS).doc(userId).get();
    List<dynamic> items = snapshot.get("cart");
    bool itemExistsInCart = false;

    // Loop through each item within the cart and add to firebase if it doesn't already exist
    items.forEach((element) {
      CartItem newItem = CartItem.fromMap(element);
      if (newItem.productId == cartItem.productId) {
        itemExistsInCart = true;
      }
    });
    if (!itemExistsInCart) {
      // Update the 'users' database with the new cart item
      _firestore.collection(USERS).doc(userId).update({
        // FieldValue arrayUnion will add item to the end of the array if not already present
        "cart": FieldValue.arrayUnion([cartItem.toMap()])
      });
    }
  }


  Future<UserModel> getUserById(String userId) => _firestore.collection(USERS).doc(userId).get().then((value){
    return UserModel.fromSnapshot(value);
  });

}
