import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/user_gps.dart';
import 'package:uber_haircuts/utilities/files.dart';
import 'package:uber_haircuts/utilities/parent_barber_firestore.dart';
import 'package:uber_haircuts/utilities/user_firestore.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import '../theme/main_theme.dart';
import 'cart.dart';
import 'login.dart';
import 'package:provider/provider.dart';

class ChangeAddress extends StatefulWidget {
  const ChangeAddress({Key key}) : super(key: key);

  @override
  _ChangeAddressState createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  final key = new GlobalKey<FormState>();

  UserFirestore _userFirestore = new UserFirestore();
  FirebaseAuth _auth;

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<Authenticate>(context);
    return Scaffold(
        body: ListView(
          children: [
            Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_outlined, color: theme,),
                        onPressed: () {Navigator.pop(context);},),

                      IconButton(
                        icon: Icon(Icons.shopping_basket, color: theme,),
                        onPressed: () {
                          if (_user.userModel.cart != null && _user.userModel.cart.isNotEmpty) {
                            navigateToScreen(context, Cart());
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: ReturnText(text: "Basket Empty", color: white,)));
                          }
                        },
                      )],
                  ),
                  Container(
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Image.asset(
                              "assets/images/logo.png", width: 200, height: 200,
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: TextField(
                                  controller: _numberController,
                                  decoration: InputDecoration(
                                    labelText: "Street Number",
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: TextField(
                                  controller: _streetController,
                                  decoration: InputDecoration(
                                    labelText: "Street Name",
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: TextField(
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                    labelText: "City",
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(7),
                                  ],
                                  controller: _postcodeController,
                                  decoration: InputDecoration(
                                    labelText: "Postcode",
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35, 40, 35, 30),
                              child: SizedBox(
                                height: 70,
                                child: Material(
                                  borderRadius: BorderRadius.circular(15),
                                  shadowColor: theme,
                                  color: theme,
                                  child: GestureDetector(
                                    onTap: () async {

                                      PlaceModel _placeModel = new PlaceModel(
                                          number: _numberController.text,
                                          street: _streetController.text,
                                          city: _cityController.text,
                                          postcode: _postcodeController.text
                                      );
                                      var locationMap = _user.createLocationMap(_placeModel);
                                      _userFirestore.updateAddress(locationMap, _auth.currentUser.uid);
                                    },
                                    child: Center(
                                      child: ReturnText(text: 'Update Address', fontWeight: FontWeight.w400, size: 30, color: white,),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ])
                  ),
                ]),
          ],
        )
    );
  }

}
