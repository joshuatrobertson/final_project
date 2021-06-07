import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/models/prices.dart';

import '../common_items.dart';

class Checkout extends StatefulWidget {
  final Prices prices;

  createState() => _CheckoutState();

  Checkout(this.prices);

}


class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: theme,),
            onPressed: () {Navigator.pop(context);},),
        ],
        ],
      )
    );
  }
}

