import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/theme/common_items.dart';
import 'package:uber_haircuts/helpers/navigate.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';

import 'cart.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;

  createState() => _ProductDetailsState();

  ProductDetails({@required this.product});

}

class _ProductDetailsState extends State<ProductDetails> {
  int x = 1;
  int _navIndex = 0;
  List<Widget> _widget = <Widget>[
    Text('Home'),
    Text('My Account'),
    Text('Shopping Cart'),
    Text('My Orders'),
  ];

  void _onClick(int index) {
    setState(() {
      _navIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Authenticate>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Stack(
              children: [
                Image(
                    image: NetworkImage(widget.product.image)),
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
            ReturnText(text: widget.product.name, size: 30),
            ReturnText(text: "£" + widget.product.price.toString(), color: theme, size: 20),
            ReturnText(text: widget.product.description, size: 10),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  IconButton(icon: Icon(Icons.remove), onPressed: (){
                    setState(() {
                      if (x > 1) {
                        x--;
                      }
                    });
                  }),
                  GestureDetector(
                  onTap: () {
                    // Add the item to the current user fetched from Provider of Authenticate class
                    user.addItemToCart(productModel: widget.product, quantity: x);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: ReturnText(text: "Add " + x.toString() + " to Basket", color: Colors.white,),
                    ),
                  ),
                ),
                  IconButton(icon: Icon(Icons.add), onPressed: (){
                    if (x < 99) {
                      setState(() {
                      x++;
                    });
                  }
                  }),
                ]),
            ),
          ],
        ),
    );
  }
}

