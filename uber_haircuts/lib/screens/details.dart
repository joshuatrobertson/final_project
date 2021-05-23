import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/common_items.dart';
import 'package:uber_haircuts/models/product.dart';

class Details extends StatefulWidget {
  final Product product;

  createState() => _DetailsState();

  Details(this.product);

}



class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[

        ],
      )
    );
  }
}

