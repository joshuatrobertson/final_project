import 'package:flutter/material.dart';

import '../common_items.dart';

class ReturnText extends StatelessWidget {
  final String text;
  final double size;
  final String fontFamily;
  final Color color;
  final FontWeight fontWeight;


  ReturnText(
  {@required this.text, this.size, this.fontFamily, this.color, this.fontWeight}
      );

  @override
  Widget build(BuildContext context) {
    // Return the default values specified for missing input items
    return Text(this.text, style: TextStyle(fontSize: this.size ?? 14, fontFamily: this.fontFamily ?? 'Poppins', color: this.color ?? black, fontWeight: this.fontWeight ?? FontWeight.normal));
  }
}
