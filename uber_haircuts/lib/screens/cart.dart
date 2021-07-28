import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/cart.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/utilities/order.dart';
import 'package:uber_haircuts/utilities/user_firestore.dart';
import 'package:uber_haircuts/widgets/return_image.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';

class Cart extends StatefulWidget {

  createState() => _CartState();

  Cart();
}

class _CartState extends State<Cart> {
  num total = 0;
  num serviceCharge = 1.99;

  // Regular expression to remove any trailing zeroes to add to UI design
  RegExp _regex = RegExp(r"([.]*0)(?!.*\d)");

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Authenticate>(context);
    OrderUtility orderUtility = new OrderUtility();
    UserFirestore userFirestore = new UserFirestore();

    getTotalPrice(user.userModel.cart);

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
          backgroundColor: lightGrey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: theme,),
            onPressed: () {Navigator.pop(context);},
          ),
          title: Center(child: ReturnText(text: "Shopping Cart", size: 15, fontWeight: FontWeight.w400,)),
          ),

          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: user.userModel.cart.length ?? 0,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Container(
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
                                              child: ReturnImage(image: user.userModel.cart[index].product.image, width: 150, height: 100)
                                          )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4, left: 10),
                                          child:
                                          Container(
                                            width: 150,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ReturnText(text: user.userModel.cart[index].product.name,
                                                  size: 15,
                                                  fontWeight: FontWeight.bold,
                                                  align: TextAlign.left,),

                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      ReturnText(text: "£" +
                                                          user.userModel.cart[index].product.price.toString(),
                                                        size: 14,
                                                        color: accent_1,),
                                                    ]
                                                )
                                              ],
                                            ),
                                          ),

                                        ),
                                      ],
                                    ),
                                  ),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:[
                                            IconButton(icon: Icon(Icons.remove), onPressed: (){
                                              setState(() {
                                                if (user.userModel.cart[index].quantity > 1) {
                                                  user.userModel.cart[index].updateQuantity('decrease');
                                                }
                                              });
                                            }),
                                            GestureDetector(
                                              onTap: () {
                                                // TODO: display snackbar when item is already in cart
                                                // Add the item to the current user fetched from Provider of Authenticate class
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: lightGrey,
                                                  border: Border.all(color: Colors.black12),
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                                  child: ReturnText(text: user.userModel.cart[index].quantity.toString(), color: Colors.black,),
                                                ),
                                              ),
                                            ),
                                            IconButton(icon: Icon(Icons.add), onPressed: (){
                                              if (user.userModel.cart[index].quantity < 99) {
                                                setState(() {
                                                  user.userModel.cart[index].updateQuantity('increase');
                                                });
                                              }
                                            }),
                                          ]),
                                    IconButton(
                                      icon: Icon(Icons.delete_forever, color: theme,),
                                      onPressed: () {
                                        setState(() {
                                          user.userModel.removeFromCart(index);
                                        });
                                      },
                                    ),
                                    ]),
                              );
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 0, 20),
                      child: ReturnText(text: "Customer Location", size: 22, align: TextAlign.left, fontWeight: FontWeight.bold,),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_rounded, color: theme,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ReturnText(text: user.userModel.locationDetails.number + " " + user.userModel.locationDetails.street, fontWeight: FontWeight.bold),
                                      ReturnText(text: user.userModel.locationDetails.postcode),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ReturnText(text: "Edit", decoration: TextDecoration.underline, color: Colors.blue,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                              alignment: Alignment.bottomLeft,
                              child: ReturnText(text: 'Order Info', size: 22, align: TextAlign.left, fontWeight: FontWeight.bold,),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                                child: ReturnText(text: "Subtotal"),
                                alignment: Alignment.bottomLeft,
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                                child: ReturnText(text: "£" + total.toString().replaceAll(_regex, "")),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                                child: ReturnText(text: "Service Charge"),
                                alignment: Alignment.bottomLeft,
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                                child: ReturnText(text: "£" + serviceCharge.toString().replaceAll(_regex, "")),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                                child: ReturnText(text: "Total Cost"),
                                alignment: Alignment.bottomLeft,
                              ),
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                                child: ReturnText(text: "£" + (total + serviceCharge).toString().replaceAll(_regex, ""), size: 20, fontWeight: FontWeight.bold,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 20),
                      child: GestureDetector(
                        onTap: () {
                          // TODO: navigate to checkout screen
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                            child: ReturnText(text: "Checkout", color: white,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        )
    );
  }

  void getTotalPrice(List<CartItem> items) {
    double totalPrice = 0;
    items.forEach((item) {
      totalPrice += item.quantity * item.product.price;
    });
    setState(() {
      total = totalPrice;
    });
  }

}
