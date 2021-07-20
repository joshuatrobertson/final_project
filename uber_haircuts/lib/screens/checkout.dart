
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/theme/main_theme.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_image.dart';
import 'package:uber_haircuts/widgets/return_text.dart';

import 'cart.dart';

class Checkout extends StatefulWidget {
  //final Prices prices;

  createState() => _CheckoutState();

  Checkout();

}


class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Authenticate>(context);
    List<ProductModel> _shoppingCart;

    return MaterialApp(
        home: Scaffold(
          backgroundColor: lightGrey,
          body: SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: user.userModel.cart.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: lightGrey,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(6.0)
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 8,
                                        blurRadius: 8,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 8.0, 8.0, 0),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(6.0),
                                            child: ReturnImage(image: user.userModel.cart[index].image,
                                              height: 100, width: 150,)
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4, left: 10),
                                        child:
                                        Container(
                                          width: 150,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ReturnText(text: _shoppingCart[index].name,
                                                size: 15,
                                                fontWeight: FontWeight.bold,
                                                align: TextAlign.left,),

                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [

                                                    ReturnText(
                                                        text: _shoppingCart[index].name,
                                                        color: Colors.black54,
                                                        size: 10),
                                                    ReturnText(text: "£" +
                                                        _shoppingCart[index].price.toString(),
                                                      size: 14,
                                                      color: Colors.redAccent,),
                                                  ]
                                              )
                                            ],
                                          ),
                                        ),

                                      ),
                                    ],
                                  ),

                                ),
                              );
                            }),
                      ),
                      Row(
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
                          )
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}

