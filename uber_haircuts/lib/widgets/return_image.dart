import 'package:flutter/material.dart';

class ReturnImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit boxFit;
  final String test;

  const ReturnImage({@required this.image, @required this.height, @required this.width, @required this.boxFit, this.test});

  @override
  Widget build(BuildContext context) {
    // Return the default values specified for missing input items
    return Image(
        image: NetworkImage(this.image),
        height: this.height,
        width: this.width,
        fit: this.boxFit
        );
    }
}