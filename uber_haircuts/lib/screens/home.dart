import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common_items.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: Scaffold (
        backgroundColor: lightGrey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: lightGrey,
          title: Row(
            children: <Widget>[
            ],
          ),
          // action used to place icon to the right
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.account_circle, size: 35, color: pink1),
                tooltip: 'View profile details',
                onPressed: () {
                  // ADD FUNCTION TO VIEW PROFILE DETAILS
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
