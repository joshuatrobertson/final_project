import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/made_orders.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/theme/main_theme.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import 'package:flutter/material.dart';


class UserOrders extends StatefulWidget {

  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  @override

    Widget build(BuildContext context) {
      final _user = Provider.of<AuthenticateProvider>(context);
      List<MadeOrdersModel> _orders = _user.userModel.orders;

      return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: lightGrey,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined, color: theme,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.shopping_basket, color: theme,),
                  onPressed: () {},
                )
              ],
            ),
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
                              itemCount: _orders.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {},
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
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4, left: 10),
                                            child:
                                            Container(
                                              width: 150,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  ListView.builder(
                                                      scrollDirection: Axis
                                                          .vertical,
                                                      itemCount: _orders.length,
                                                      itemBuilder: (_, index2) {
                                                        return ReturnText(
                                                            text: "PRODUCT ID: " +
                                                                _orders[index]
                                                                    .products[index2]
                                                                    .id);
                                                      }),
                                                  Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [

                                                        ReturnText(
                                                            text: "USER ID: " +
                                                                _orders[index]
                                                                    .userID,
                                                            color: Colors
                                                                .black54,
                                                            size: 10),
                                                        ReturnText(
                                                          text: "BARBER ID: " +
                                                              _orders[index]
                                                                  .barberID,
                                                          size: 14,
                                                          color: Colors
                                                              .redAccent,),
                                                      ]
                                                  )
                                                ],
                                              ),
                                            ),

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ]),
                ),
              ),
            ),
          ));
    }
}

