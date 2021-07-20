import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/user.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/screens/contact_us.dart';
import 'package:uber_haircuts/theme/main_theme.dart';
import 'package:uber_haircuts/utilities/user_firestore.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import 'package:uber_haircuts/widgets/return_text.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  UserModel _user;


  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<Authenticate>(context);

    return ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            children: [
              ReturnText(text: "Hello, \n", size: 22, fontWeight: FontWeight.normal,),
              ReturnText(text: _getUsername(), size: 28, fontWeight: FontWeight.bold,),
            ],
            ),
          )

        ),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListTile(
                leading: Icon(Icons.shopping_bag_outlined, color: theme),
                title: ReturnText(text: "My Orders", align: TextAlign.left, size: 18, fontWeight: FontWeight.w500,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Icon(Icons.arrow_forward_ios_rounded, color: theme,),
            )
          ]
        ),
        ListTile(
          leading: Icon(Icons.account_circle, color: theme,),
          title: ReturnText(text: "Account Settings", align: TextAlign.left, size: 18, fontWeight: FontWeight.w500,) ,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
          child: Container(
              alignment: Alignment.bottomLeft,
              child: ReturnText(text: "My Profile")),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 10, 0, 0),
          child: GestureDetector(
            onTap: () async {
              authProvider.signOut();
            },
            child: Container(
                alignment: Alignment.bottomLeft,
                child: ReturnText(text: "Sign Out")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 10, 0, 0),
          child: Container(
              alignment: Alignment.bottomLeft,
              child: ReturnText(text: "My Address")),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 10, 0, 0),
          child: Container(
              alignment: Alignment.bottomLeft,
              child: ReturnText(text: "Manage Payment Preferences")),
        ),
        ListTile(
          leading: Icon(Icons.settings, color: theme),
          title: ReturnText(text: "Help and support", align: TextAlign.left, size: 18, fontWeight: FontWeight.w500,),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
          child: GestureDetector(
            onTap: () async {
              navigateToScreen(context, ContactUs());
            },
            child: Container(
                alignment: Alignment.bottomLeft,
                child: ReturnText(text: "Contact Us")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 10, 0, 0),
          child: Container(
              alignment: Alignment.bottomLeft,
              child: ReturnText(text: "Join as a Barber")),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 10, 0, 0),
          child: Container(
              alignment: Alignment.bottomLeft,
              child: ReturnText(text: "Give us feedback")),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(75, 10, 0, 0),
          child: Container(
              alignment: Alignment.bottomLeft,
              child: ReturnText(text: "About")),
        ),
      ],
    );
  }

  String _getUsername() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth.currentUser.displayName;
  }
}