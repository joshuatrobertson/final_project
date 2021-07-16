import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/models/user.dart';
import 'package:uber_haircuts/utilities/user_database.dart';
import 'package:uber_haircuts/widgets/return_text.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  UserModel _user;


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
          ),
          child: Column(

          children: [
            ReturnText(text: "Hello, \n"),
            ReturnText(text: _getUsername()),
          ],
          )

        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('Messages'),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
      ],
    );
  }

  String _getUsername() {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth.currentUser.displayName;
  }
}