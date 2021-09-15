// Class representing a barber product
import 'package:cloud_firestore/cloud_firestore.dart';

// List of products barbers can use
enum allowedProducts {
  HAIRCUT,
  SHAVE,
  STUDENT_CUT,
}

var allowedProductsString = {
  "Haircut",
  "Shave",
  "Student Cut",
};

var productImages = {
  "https://firebasestorage.googleapis.com/v0/b/uber-haircuts.appspot.com/o/products%2Fhair_cut.jpg?alt=media&token=f24e8e0b-64fb-49e2-b73d-c7e2e8d0ec0b",
  "https://firebasestorage.googleapis.com/v0/b/uber-haircuts.appspot.com/o/products%2Fbeard_trim.jpg?alt=media&token=e26f73d4-8c73-4366-aa0c-971dcf32f376",
  "https://firebasestorage.googleapis.com/v0/b/uber-haircuts.appspot.com/o/products%2Fstudent_cut.jpg?alt=media&token=197b7101-672d-4bfe-9131-90924a257cb2",
};


class ProductModel {

  static const ID = "id";
  static const NAME = "name";
  static const DESCRIPTION = "description";
  static const PRICE = "price";
  static const IMAGE = "image";
  static const FEATURED = "featured";
  static const BARBER_ID = "barberID";

  String _id;
  String _name;
  String _description;
  num _price;
  String _image;
  bool _featured;
  String _barberID;

  String get id => _id;
  String get name => _name;
  String get description => _description;
  num get price => _price;
  String get image => _image;
  bool get featured => _featured;
  String get barberID => _barberID;

  set id(String id) => _id;
  set name(String name) => _name;
  set description(String description) => _description;
  set price(num price) => _price;
  set image(String image) => _image;
  set featured(bool featured) => _featured;
  set barberID(String barberID) => _barberID;

  ProductModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _id = documentSnapshot.id;
    _name = documentSnapshot.data()[NAME];
    _description = documentSnapshot.data()[DESCRIPTION];
    _price = documentSnapshot.data()[PRICE];
    _image = documentSnapshot.data()[IMAGE];
    _featured = documentSnapshot.data()[FEATURED];
    _barberID = documentSnapshot.data()[BARBER_ID];
  }

  ProductModel.fromMap(Map product) {
    _id = product[ID];
    _name = product[NAME];
    _description = product[DESCRIPTION];
    _price = product[PRICE];
    _image = product[IMAGE];
    _featured = product[FEATURED];
    _barberID = product[BARBER_ID];
  }

  Map toMap() => {
    ID: _id,
    NAME: _name,
    DESCRIPTION: _description,
    PRICE: _price,
    IMAGE: _image,
    FEATURED:_featured,
    BARBER_ID: _barberID,
  };

  ProductModel();

}