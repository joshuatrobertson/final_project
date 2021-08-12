import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/cart.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:uber_haircuts/models/user.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/utilities/parent_barbers_firestore.dart';

class OrderUtility {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const USERS = "users";
  static const BARBERS = "parentBarber";


  Future<void> addToCart({String userId, CartModel cartItem}) async {

    final DocumentSnapshot snapshot = await _firestore.collection(USERS).doc(userId).get();
    List<dynamic> items = snapshot.get("cart");
    bool itemExistsInCart = false;

    // Loop through each item within the cart and add to firebase if it doesn't already exist
    items.forEach((element) {
      CartModel newItem = CartModel.fromMap(element);
      if (newItem.productID == cartItem.productID) {
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


  Future<void> updateCartFirestore({String userId}) async {
    UserModel userModel = await getUserById(userId);
    List<CartModel> orderItems = userModel.cart;

    try {
      List<dynamic> newOrders = [];
      for (CartModel cartItem in orderItems) {
          newOrders.add(cartItem.toMap());
      }
      await _firestore.collection(USERS).doc(userId).update({
        "cart": newOrders
      });
    } catch(e) {
      print("Error deleting item from firestore cart: " + e.toString());
    }
  }

  Future<List<CartModel>> getDatabaseCartItems(String userId) async {
    ParentBarbersFirestore _parentBarbersFirestore = new ParentBarbersFirestore();
    final DocumentSnapshot snapshot = await _firestore.collection(USERS).doc(userId).get();
    List<dynamic> items = snapshot.get("cart");
    List<CartModel> orders = [];

    if (items.isNotEmpty) {
      items.forEach((element) async {
        // Fetch the CartItem from the database
        CartModel newItem = CartModel.fromMap(element);
        // Fetch the ProductModel from the product Id
        ProductModel product = await _parentBarbersFirestore.getProductFromId(newItem.productID);
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

  Future<ParentBarberModel> getBarberById(String userId) => _firestore.collection(BARBERS).doc(userId).get().then((value){
    return ParentBarberModel.fromSnapshot(value);
  });

}
