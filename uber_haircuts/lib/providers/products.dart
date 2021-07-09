import 'package:flutter/cupertino.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:uber_haircuts/utilities/products_firestore.dart';

class ProductsProvider extends ChangeNotifier {

  // Create an instance of firestore
  ProductsFirestore _productsFirestore = ProductsFirestore();
  List<ProductModel> _products = [];

  get products => _products;

  ProductsProvider() {
    _loadProducts();
  }

  _loadProducts() async {
    _products = await _productsFirestore.getProducts();
    notifyListeners();
  }
}