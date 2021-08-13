import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class LocationFirestore {

  // Connect to the database and create a collection reference with the top level collection (ParentBarber)
  final CollectionReference _collectionReferenceParents = FirebaseFirestore.instance.collection('parentBarber');
  final CollectionReference _collectionReferenceBarbers = FirebaseFirestore.instance.collection('barbers');
  final CollectionReference _collectionReferenceProducts = FirebaseFirestore.instance.collection('products');
  final geoflutterfire = Geoflutterfire();
  var items;


  Future<List<ParentBarberModel>> getLocalParents(double latitude, double longitude, double radius) async {
    // Set the centre point given the latitude and longitude
    GeoFirePoint center = geoflutterfire.point(latitude: latitude, longitude: longitude);

    try {
      Stream<List<DocumentSnapshot>> stream = geoflutterfire
          .collection(collectionRef: _collectionReferenceParents)
          .within(center: center, radius: radius, field: 'location');
      await for (var docs in stream) {
        List<ParentBarberModel> parentBarbers = [];
        for (DocumentSnapshot parent in docs) {
          ParentBarberModel barber = ParentBarberModel.fromSnapshot(parent);
          parentBarbers.add(barber);
        }
        return parentBarbers;
      }
    }
    catch(e) {
      print("Fetching local items failed with error: " + e.toString());
    }
  }

  // Fetch the barbers
  Future<List<BarberModel>> getBarbers(double latitude, double longitude, double radius) async {
    GeoFirePoint center = geoflutterfire.point(latitude: latitude, longitude: longitude);

    try {
      Stream<List<DocumentSnapshot>> stream = geoflutterfire
          .collection(collectionRef: _collectionReferenceBarbers)
          .within(center: center, radius: radius, field: 'location');
      await for (var docs in stream) {
        List<BarberModel> barberList = [];
        for (DocumentSnapshot barbers in docs) {
          BarberModel barber = BarberModel.fromSnapshot(barbers);
          barberList.add(barber);
        }
        return barberList;
      }
    }
    catch (e) {
      print('Fetching local barbers failed with error: ' + e.toString());
    }
  }

  // Fetch the products
  Future<List<ProductModel>> getProducts() async =>
      _collectionReferenceProducts.get().then((product) {
    List<ProductModel> products = [];
      for (DocumentSnapshot newProduct in product.docs) {
        ProductModel _productModel = ProductModel.fromSnapshot(newProduct);
        products.add(_productModel);
      }
      return products;
    });

  Future<ProductModel> getProductFromId(String productId) async =>
      _collectionReferenceProducts.doc(productId).get().then((value) {
        ProductModel productModel;
        productModel = ProductModel.fromSnapshot(value);
        return productModel;
    });


  LocationFirestore();



}