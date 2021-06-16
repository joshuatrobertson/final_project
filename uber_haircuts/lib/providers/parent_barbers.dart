import 'package:flutter/cupertino.dart';
import 'package:uber_haircuts/helpers/parent_barbers_firestore.dart';
import 'package:uber_haircuts/models/parent_barber.dart';

class ParentBarbersProvider extends ChangeNotifier {

  // Create an instance of firestore
  ParentBarbersFirestore _parentFirestore = ParentBarbersFirestore();
  List<ParentBarberModel> _parents = [];

  get parents => _parents;

  ParentBarbersProvider() {
    _loadParents();
  }

  _loadParents() async {
    _parents = await _parentFirestore.getParentBarbers();
    notifyListeners();
  }

}