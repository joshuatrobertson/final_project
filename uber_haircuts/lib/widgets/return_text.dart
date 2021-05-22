import 'package:flutter/material.dart';

import '../common_items.dart';

class ReturnText extends StatelessWidget {
  final String inputText;
  final double size;
  final Color color;
  final FontWeight fontWeight;


  ReturnText({@required this.inputText, this.size, this.color, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    // Return the default values specified for missing input items
    return Text(this.inputText, style: TextStyle(fontSize: this.size ?? 14, color: this.color ?? black, fontWeight: this.fontWeight ?? FontWeight.normal));
  }
}
