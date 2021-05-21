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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.account_circle,
                  color: pink1,
                ),
              )
            ],
          ),
          actions: <Widget>[ // add the icon to this list
            Icon(
              Icons.account_circle,
              color: pink1,
            ),
          ],
        ),
      ),
    );
  }
}
