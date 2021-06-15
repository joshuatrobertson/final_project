import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/common_items.dart';
import 'package:uber_haircuts/helpers/navigate.dart';
import 'package:uber_haircuts/screens/checkout.dart';
import 'package:uber_haircuts/models/order.dart';
import 'package:uber_haircuts/widgets/return_text.dart';

import 'cart.dart';

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
                        onPressed: () {
                          navigateToScreen(context, Cart());
                        },
                      )],
                  ),
                )
              ],
            ),
            ReturnText(text: widget.product.product.name, size: 30),
            ReturnText(text: "£" + widget.product.price.toString(), size: 20),
            ReturnText(text: widget.product.product.description),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: GestureDetector(
                onTap: () {
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: theme,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: ReturnText(text: "Add to Basket", color: Colors.white,),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                label: 'My Account',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: 'Shopping Cart',
              ),
            ])
    );
  }
}

