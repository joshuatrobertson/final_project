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

}