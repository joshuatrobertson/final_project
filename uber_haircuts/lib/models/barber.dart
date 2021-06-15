import 'package:uber_haircuts/models/order.dart';
import 'package:uber_haircuts/models/product.dart';


// Class representing a barber including a list of Product classes
class Barber {

  final int id;
  final String name;
  final String image;
  final String description;
  final String parentBarber;
  final double rating;
  final bool featured;
  final bool availableNow;
  final List<Prices> barberProducts;

  Barber(this.id, this.name, this.image, this.description, this.parentBarber,
      this.rating, this.featured, this.availableNow, this.barberProducts);
}
