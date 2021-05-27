import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/prices.dart';

class ProductDetails extends StatefulWidget {
  final Prices product;

  createState() => _ProductDetailsState();

  ProductDetails({@required this.product});

}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Text(widget.product.price.toString()),
          Text(widget.product.product.name),
          Text(widget.product.product.description),
        ],
      )
    );
  }
}

