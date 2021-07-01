import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../common_items.dart';

class Cart extends StatefulWidget {

  createState() => _CartState();

  Cart();

}

class _CartState extends State<Cart> {
  int total = 0;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Authenticate>(context);

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
                            itemCount: 0 ?? user.userModel.cart.length,
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
                                              child: Image(
                                                image: NetworkImage(user.userModel.cart[index].image),
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
                                                ReturnText(text: user.userModel.cart[index].name,
                                                  size: 15,
                                                  fontWeight: FontWeight.bold,
                                                  align: TextAlign.left,),

                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [

                                                      ReturnText(
                                                          text: user.userModel.cart[index].name,
                                                          color: Colors.black54,
                                                          size: 10),
                                                      ReturnText(text: "£" +
                                                          user.userModel.cart[index].price.toString(),
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
                                    IconButton(
                                      icon: Icon(Icons.delete_forever, color: theme,),
                                      onPressed: () {},
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
