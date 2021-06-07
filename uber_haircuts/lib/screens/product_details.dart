import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/common_items.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/prices.dart';
import 'package:uber_haircuts/widgets/return_text.dart';

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
          Stack(
            children: [
              Image.asset("assets/images/${widget.product.product.image}.jpg"),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_outlined, color: theme,),
                      onPressed: () {Navigator.pop(context);},),

                    IconButton(
                      icon: Icon(Icons.shopping_basket, color: theme,),
                      onPressed: () {Navigator.pop(context);},),
                  ],
                ),
              )
            ],
          ),
          ReturnText(text: widget.product.product.name, size: 30),
          ReturnText(text: "£" + widget.product.price.toString(), size: 20),
          ReturnText(text: widget.product.product.description),
        Container(
          decoration: BoxDecoration(
            color: accent_1,
          ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: ReturnText(text: "Add to Basket"),
        ),
        ),
        ],
      )
    );
  }
}

