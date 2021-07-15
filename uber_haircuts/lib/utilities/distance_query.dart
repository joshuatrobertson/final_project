import 'package:location/location.dart';
import 'package:uber_haircuts/models/parent_barber.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DistanceQuery {

  final geo = Geoflutterfire();
  final _firestore = FirebaseFirestore.instance;


  Stream<List<DocumentSnapshot>> getLocalItems() {
    GeoFirePoint center = geo.point(latitude: 51.466627397117726, longitude: -2.61624);
    CollectionReference collectionReference = _firestore.collection('parentBarber');
    double radius = 200;
    String field = 'location';
    var geoRef = geo.collection(collectionRef: collectionReference);
    return geoRef.within(center: center, radius: radius, field: 'location', strictMode: true);
  }

  List<String> getHash() {

    return ["12", "14"];
  }

}