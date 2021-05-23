import 'package:uber_haircuts/models/prices.dart';
import 'package:uber_haircuts/models/product.dart';


// Class representing a barber including a list of Product classes
class Barber {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const DESCRIPTION = "description";
  static const PARENT_BARBER = "parentBarber";
  static const RATING = "rating";
  static const FEATURED = "featured";
  static const USER_LIKES = "userLikes";
  static const AVAILABLE_NOW = "availableNow";
  static const BARBER_PRODUCTS = "barberProducts";


  int _id;
  String _name;
  String _image;
  String _description;
  String _parentBarber;
  double _rating;
  bool _featured;
  bool _availableNow;
  List<Product> _barberProducts;

  // Getter functions
  int get id => _id;

  String get name => _name;

  String get image => _image;

  String get description => _description;

  String get parentBarber => _parentBarber;

  double get rating => _rating;

  bool get featured => _featured;

  bool get availableNow => _availableNow;

  List<Product> get barberProducts =>_barberProducts;


  // public variable
  bool liked = false;

  Barber.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _image = snapshot.data[IMAGE];
    _description = snapshot.data[DESCRIPTION];
    _featured = snapshot.data[FEATURED];
    _rating = snapshot.data[RATING];
    _availableNow = snapshot.data[AVAILABLE_NOW];
    _barberProducts = snapshot.data[BARBER_PRODUCTS];

  }
}
