import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/models/product.dart';


class ParentBarbersFirestore {

  // Connect to the database and create a collection reference with the top level collection (ParentBarber)
  final Query _collectionReferenceParents = FirebaseFirestore.instance.collection('parentBarber');
  final CollectionReference _collectionReferenceBarbers = FirebaseFirestore.instance.collection('barbers');
  final CollectionReference _collectionReferenceProducts = FirebaseFirestore.instance.collection('products');

  // Fetch the featured barbers to use in top_rated.dart
  Future<List<ParentBarberModel>> getTopRatedParents() async =>
      // Go through the collection 'parentBarbers' and order by rating (descending) to fetch the top 5 rated barbers
  _collectionReferenceParents.orderBy("rating", descending: true).limit(5).get().then((value) {
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
  _collectionReferenceParents.get().then((value) {
    List<ParentBarberModel> parents = [];
    // for each item within the parent barbers add to a list and return
    for (DocumentSnapshot parent in value.docs) {
      parents.add(ParentBarberModel.fromSnapshot(parent));
    }
    return parents;
  });

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
        print("BARBERS NAME: " + _barberModel.firstName);
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
        print("PRODUCT NAME: " + _productModel.name);
        products.add(_productModel);
      }
      return products;
    });

  ParentBarbersFirestore();

}