import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Bidirectional screen navigation
void navigateToScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

// One way screen replacement
void replaceScreen(BuildContext context, Widget widget) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
}