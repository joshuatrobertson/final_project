import 'package:flutter/cupertino.dart';
import 'package:uber_haircuts/models/product.dart';

class CartItem {
  final String id;
  final ProductModel product;
  final int quantity;

  CartItem (
  {@required this.id, @required this.product, @required this.quantity}
      )

  class Cart with ChangeNotifier {

  }

}