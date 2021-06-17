import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/parent_barber.dart';

class ParentBarbersFirestore {

  // Connect to the database and create a collection reference
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('parentBarber');


  Future<List<ParentBarberModel>> getParentBarbers() async =>
      // Go through the collection 'parentBarbers'
  _collectionReference.where("featured", isEqualTo: true).get().then((value) {
    List<ParentBarberModel> parents = [];
    // for each item within the parent barbers add to a list and return
    for (DocumentSnapshot parent in value.docs) {
      parents.add(ParentBarberModel.fromSnapshot(parent));
    }
    return parents;
  });


  ParentBarbersFirestore();

}