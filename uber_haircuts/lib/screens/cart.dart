import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/widgets/return_image.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';

class Cart extends StatefulWidget {

  createState() => _CartState();

  Cart();

}

class _CartState extends State<Cart> {
  num total = 0.0;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Authenticate>(context);
    num x = 0;

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
          backgroundColor: lightGrey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, color: theme,),
            onPressed: () {Navigator.pop(context);},
          ),
          title: Center(child: ReturnText(text: "Shopping Cart", size: 25, fontWeight: FontWeight.w400,)),
          ),

          body: SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: user.userModel.cart.length ?? 0,
                            itemBuilder: (_, index) {
                             //total = user.userModel.cart[index].product.price + total;

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
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                        alignment: Alignment.bottomLeft,
                          child: ReturnText(text: 'Total = £' + total.toString(), size: 24,)),
                    ])
              ),
            ),
          ),
        )
    );
  }
}
