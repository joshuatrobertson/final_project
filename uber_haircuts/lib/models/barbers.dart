import 'package:uber_haircuts/models/products.dart';


// Class representing a barber including a list of Product classes
class Barber {
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const DESCRIPTION = "description";
  static const FEATURED = "featured";
  static const RATES = "rates";
  static const USER_LIKES = "userLikes";
  static const AVAILABLE_NOW = "availableNow";
  static const BARBER_PRODUCTS = "barberProducts";


  String _id;
  String _name;
  String _category;
  String _image;
  String _description;
  double _rating;
  int _rates;
  bool _featured;
  bool _availableNow;
  List<Product> _barberProducts;

  // Getter functions
  String get id => _id;

  String get name => _name;

  String get restaurant => _restaurant;

  String get restaurantId => _restaurantId;

  String get category => _category;

  String get description => _description;

  String get image => _image;

  double get rating => _rating;

  int get price => _price;

  bool get featured => _featured;

  int get rates => _rates;

  bool get availableNow => _availableNow;

  List<Product> get barberProducts =>_barberProducts;


  // public variable
  bool liked = false;

  Barber.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _image = snapshot.data[IMAGE];
    _restaurant = snapshot.data[RESTAURANT];
    _restaurantId = snapshot.data[RESTAURANT_ID].toString();
    _description = snapshot.data[DESCRIPTION];
    _id = snapshot.data[ID];
    _featured = snapshot.data[FEATURED];
    _price = snapshot.data[PRICE].floor();
    _category = snapshot.data[CATEGORY];
    _rating = snapshot.data[RATING];
    _rates = snapshot.data[RATES];
    _name = snapshot.data[NAME];
    _availableNow = snapshot.data[AVAILABLE_NOW];
    _barberProducts = snapshot.data[BARBER_PRODUCTS];

  }
}
