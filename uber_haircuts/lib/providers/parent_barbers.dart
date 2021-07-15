import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/models/barber.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:uber_haircuts/models/product.dart';
import 'package:uber_haircuts/utilities/parent_barbers_firestore.dart';
import 'package:uber_haircuts/widgets/filter_list.dart';

import 'authenticate.dart';

class ParentBarbersProvider extends ChangeNotifier {

  // Create an instance of firestore
  ParentBarbersFirestore _parentFirestore = ParentBarbersFirestore();
  final FilterList _filterList = new FilterList();


  List<ParentBarberModel> _allParents = [];
  List<ParentBarberModel> _featuredParents = [];
  List<ParentBarberModel> _topRatedParents = [];
  List<BarberModel> _barbers = [];
  List<ProductModel> _products = [];

  get allParents => _allParents;
  get featuredParents => _featuredParents;
  get topRatedParents => _topRatedParents;
  get barbers => _barbers;
  get products => _products;

  ParentBarbersProvider() {
    _loadParents();
    _loadBarbers();
    _loadProducts();
  }

  // Returns a list of ProductModel using getProducts() of parent_barbers_firestore.dart
  _loadProducts() async {
    try {
      _products = await _parentFirestore.getProducts();
      notifyListeners();
      print("Products loaded!");
    } catch (e) {
      print("Loading of products failed with error: " + e.toString());
    }
  }

  // Returns a list of ParentBarberModel
  _loadParents() async {
    try {
      _allParents = await _parentFirestore.getLocalItems(51.466627397117726, -2.61624, 50);
      notifyListeners();
      // Load all the items into memory to reduce server calls and decrease load/ lookup times
      print("Parent barbers loaded!");
    } catch (e) {
      print("Loading of parent barbers failed with error: " + e.toString());    }
  }

  // Returns a list of BarberModel
  _loadBarbers() async {
    try {
      _barbers = await _parentFirestore.getBarbers();
      notifyListeners();
      print('Barbers loaded!');
    } catch (e) {
      print("Loading of barbers failed with error: " + e.toString());
    }
  }

}