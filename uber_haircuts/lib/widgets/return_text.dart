import 'package:flutter/material.dart';

import '../common_items.dart';

class ReturnText extends StatelessWidget {
  final String text;
  final TextAlign align;
  final double size;
  final String fontFamily;
  final Color color;
  final FontWeight fontWeight;

  ReturnText(
  {@required this.text, this.align, this.size, this.fontFamily, this.color, this.fontWeight}
      );

  @override
  Widget build(BuildContext context) {
    // Return the default values specified for missing input items
    return Text(
        this.text, textAlign: this.align ?? TextAlign.center,
        style: TextStyle(
        fontSize: this.size ?? 14,
        fontFamily: this.fontFamily ?? 'Poppins',
        color: this.color ?? black,
        fontWeight: this.fontWeight ?? FontWeight.normal,
    )
    );
  }
}
