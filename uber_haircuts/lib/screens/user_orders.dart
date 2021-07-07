import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import 'package:flutter/material.dart';


class UserOrders extends StatefulWidget {

  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  @override
  Widget build(BuildContext context) {
    // Get the currently signed in user via FirebaseAuth
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    return ReturnText(text: "Signed in as: " + user.email);
  }
}
