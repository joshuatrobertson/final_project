import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/cart.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:uber_haircuts/models/user.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/utilities/parent_barbers_firestore.dart';

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
        // FieldValue arrayUnion will add the item to the end of the array if not already present
        "cart": FieldValue.arrayUnion([cartItem.toMap()])
      });
    }
  }


  Future<void> deleteItemFromCart({String userId, int index}) async {
    UserModel userModel = await getUserById(userId);
    List<CartItem> orderItems = userModel.cart;
    orderItems.removeAt(index);

    try {
      List<dynamic> newOrders = [];
      for (CartItem cartItem in orderItems) {
          newOrders.add(cartItem.toMap());
      }
      await _firestore.collection(USERS).doc(userId).update({
        "cart": newOrders
      });
    } catch(e) {
      print("Error deleting item from firestore cart: " + e.toString());
    }
  }

  Future<List<CartItem>> getDatabaseCartItems(String userId) async {
    ParentBarbersFirestore _parentBarbersFirestore = new ParentBarbersFirestore();
    final DocumentSnapshot snapshot = await _firestore.collection(USERS).doc(userId).get();
    List<dynamic> items = snapshot.get("cart");
    List<CartItem> orders = [];

    if (items.isNotEmpty) {
      items.forEach((element) async {
        // Fetch the CartItem from the database
        CartItem newItem = CartItem.fromMap(element);
        // Fetch the ProductModel from the product Id
        ProductModel product = await _parentBarbersFirestore.getProductFromId(newItem.productId);
        newItem.product = product;
        orders.add(newItem);
      });
      print("Shopping cart loaded from the database");
    }
      return orders;
  }

  

  Future<UserModel> getUserById(String userId) => _firestore.collection(USERS).doc(userId).get().then((value){
    return UserModel.fromSnapshot(value);
  });

}
