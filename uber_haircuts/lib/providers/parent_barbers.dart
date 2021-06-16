import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/helpers/products_firestore.dart';
import 'package:uber_haircuts/models/product.dart';

class ParentBarbers extends ChangeNotifier {

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