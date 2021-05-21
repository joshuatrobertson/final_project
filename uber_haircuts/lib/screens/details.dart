import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/models/products.dart';

class Details extends StatefulWidget {
  final Product product;

  createState() => _DetailsState();

  Details(this.product);

}



class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFFEFEFEF),
      body: Column(
        children: <Widget>[

        ],
      )
    );
  }
}

