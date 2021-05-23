import 'package:uber_haircuts/models/product.dart';


// Class representing a barber including a list of Product classes
class Prices {

  final int id;
  final double price;
  final Product product;
  final bool featured;

  Prices(this.id, this.price, this.product, this.featured);
}
