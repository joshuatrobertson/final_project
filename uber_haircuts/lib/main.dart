import 'package:flutter/material.dart';
import 'package:uber_haircuts/common_items.dart';
import 'package:uber_haircuts/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chop Chop',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Poppins'
      ),
      home: Home(),
    );
  }
}

