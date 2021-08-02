import 'package:flutter/material.dart';
import 'package:uber_haircuts/widgets/return_text.dart';

class BarberHome extends StatefulWidget {

  @override
  _BarberHomeState createState() => _BarberHomeState();
}

class _BarberHomeState extends State<BarberHome> {
  @override
  Widget build(BuildContext context) {
    return ReturnText(text: "BARBER HOME!!");
  }
}
