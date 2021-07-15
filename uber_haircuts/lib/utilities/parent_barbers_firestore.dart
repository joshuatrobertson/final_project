import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/utilities/distance_query.dart';

class ParentBarbersFirestore {

  // Connect to the database and create a collection reference with the top level collection (ParentBarber)
  final CollectionReference _collectionReferenceParents = FirebaseFirestore.instance.collection('parentBarber');
  final CollectionReference _collectionReferenceBarbers = FirebaseFirestore.instance.collection('barbers');
  final CollectionReference _collectionReferenceProducts = FirebaseFirestore.instance.collection('products');
  final geoflutterfire = Geoflutterfire();
  DistanceQuery _distanceQuery = DistanceQuery();
  List<String> boundaryGeohash;
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

  Future<List<ParentBarberModel>> getLocalItems(double latitude, double longitude, double searchRadius) async {
    // Set the centre point given the latitude and longitude
    GeoFirePoint center = geoflutterfire.point(latitude: latitude, longitude: longitude);
    double radius = 200;
    String field = 'location';

    try {
      Stream<List<DocumentSnapshot>> stream = geoflutterfire
          .collection(collectionRef: _collectionReferenceParents)
          .within(center: center, radius: radius, field: field);
      await for (var docs in stream) {
        List<ParentBarberModel> parentBarbers = [];
        for (DocumentSnapshot parent in docs) {
          ParentBarberModel barber = ParentBarberModel.fromSnapshot(parent);
          parentBarbers.add(barber);
          print("BARBER NAME!!: " + barber.name);
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
  Future<List<BarberModel>> getBarbers() async =>
  _collectionReferenceBarbers.get().then((barber) {
    List<BarberModel> barbers = [];
      for (DocumentSnapshot barber in barber.docs) {
        BarberModel _barberModel = BarberModel.fromSnapshot(barber);
        barbers.add(_barberModel);
      }
      return barbers;
    });

  // Fetch the products
  Future<List<ProductModel>> getProducts() async =>
      _collectionReferenceProducts.get().then((product) {
    List<ProductModel> products = [];
      for (DocumentSnapshot barber in product.docs) {
        ProductModel _productModel = ProductModel.fromSnapshot(barber);
        products.add(_productModel);
      }
      return products;
    });


  ParentBarbersFirestore();



}