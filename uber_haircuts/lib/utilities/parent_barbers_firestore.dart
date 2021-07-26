import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParentBarbersFirestore {

  // Connect to the database and create a collection reference with the top level collection (ParentBarber)
  final CollectionReference _collectionReferenceParents = FirebaseFirestore.instance.collection('parentBarber');
  final CollectionReference _collectionReferenceBarbers = FirebaseFirestore.instance.collection('barbers');
  final CollectionReference _collectionReferenceProducts = FirebaseFirestore.instance.collection('products');
  final geoflutterfire = Geoflutterfire();
  var items;


  // Fetch the featured barbers to use in top_rated.dart
  Future<List<ParentBarberModel>> getTopRatedParents() async =>
      // Go through the collection 'parentBarbers' and order by rating (descending) to fetch the top 5 rated barbers
  _collectionReferenceParents
      .orderBy("rating", descending: true)
      .limit(5).get().then((value) {
    List<ParentBarberModel> parents = [];
    // for each item within the parent barbers add to a list and return
    for (DocumentSnapshot parent in value.docs) {
      parents.add(ParentBarberModel.fromSnapshot(parent));
    }
    return parents;
  });

  // Get all parent barbers within the local area to use for the search function
  Future<List<ParentBarberModel>> getAllParentBarbers() async =>
      // Go through the collection 'parentBarbers'
  _collectionReferenceParents
      .get().then((value) {
    List<ParentBarberModel> parents = [];
    // for each item within the parent barbers add to a list and return
    for (DocumentSnapshot parent in value.docs) {
      parents.add(ParentBarberModel.fromSnapshot(parent));
    }
    return parents;
  });

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

  // Fetch the featured barbers to use in featured.dart
  Future<List<ParentBarberModel>> getFeaturedParents() async =>
      // Go through the collection 'parentBarbers'
  _collectionReferenceParents.where("featured", isEqualTo: true).get().then((parentBarber) {
    // Create an array of ParentBarberModel to pass back from the function
    List<ParentBarberModel> parents = [];
    // for each item within the parent barbers add to a list and return
    for (DocumentSnapshot parent in parentBarber.docs) {
      parents.add(ParentBarberModel.fromSnapshot(parent));
    }
    return parents;
  });

  // Fetch the barbers
  Future<List<BarberModel>> getBarbers(double latitude, double longitude, double radius) async {
    GeoFirePoint center = geoflutterfire.point(
        latitude: latitude, longitude: longitude);
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

  // ignore: missing_return
  ProductModel getProductFromId(String productId) {
      _collectionReferenceProducts.doc(productId).get().then((value) {
        ProductModel product = ProductModel.fromSnapshot(value);
        return product;
      });
  }


  ParentBarbersFirestore();



}