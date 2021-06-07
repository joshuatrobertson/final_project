import 'dart:html';

import 'package:flutter/material.dart';

import '../common_items.dart';

class BackButton extends StatefulWidget {
  const BackButton({Key key}) : super(key: key);

  @override
  _BackButtonState createState() => _BackButtonState();
}

class _BackButtonState extends State<BackButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_outlined, color: theme,),
      onPressed: () {Navigator.pop(context);},);
  }
}
