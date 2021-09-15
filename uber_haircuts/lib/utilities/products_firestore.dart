import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductsFirestore {

  // Connect to the database and create a collection reference
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('products');


  Future<List<ProductModel>> getProducts() async =>
  // Go through the collection 'products'
      _collectionReference.get().then((value) {
    List<ProductModel> products = [];
    // for each item within products add to a list and return
    for (DocumentSnapshot product in value.docs) {
      products.add(ProductModel.fromSnapshot(product));
    }
    return products;
  });

  ProductsFirestore();

  // Add each product after converting to a map for firebase
  Future<void> addProducts(List<ProductModel> products) async {
    for (ProductModel product in products) {
      await _collectionReference.doc(product.id).set(Map<String, dynamic>.from(product.toMap()));
    }
  }

  Future<ProductModel> getProductWithID(String productID) async =>
    await _collectionReference.doc(productID).get().then((product) =>
    ProductModel.fromSnapshot(product));

}