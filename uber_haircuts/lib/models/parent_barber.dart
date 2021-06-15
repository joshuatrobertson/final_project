import 'package:flutter/cupertino.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/order.dart';
import 'package:uber_haircuts/models/product.dart';


// Class representing a barber including a list of Product classes
class ParentBarber {

  final int id;
  final String name;
  final String image;
  final String description;
  final double rating;
  final bool featured;
  final List<Barber> barbers;

  ParentBarber({this.id, @required this.name, this.image, this.description, this.rating,
      this.featured, this.barbers});
}
