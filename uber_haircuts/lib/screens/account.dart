import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_haircuts/models/user.dart';
import 'package:uber_haircuts/utilities/user_firestore.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import 'package:flutter/material.dart';


class Account extends StatefulWidget {

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    // Get the currently signed in user via FirebaseAuth and the stored document 'uid' in the collection 'users'
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    UserFirestore userDatabase = new UserFirestore();
    UserModel userModel = userDatabase.getSingleUserById(user.uid);
    print("MODEL: " + userModel.uid);

    return ReturnText(text: "Signed in as: ");
  }
}

