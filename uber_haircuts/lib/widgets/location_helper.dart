import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dart_geohash/dart_geohash.dart';

Future<CoordModel> returnGeohash(String address) async {


  // Fetch the co-ordinates given the address
  var locations = await locationFromAddress(address);
  var firstLocation = locations.first;

  // Fetch the geohash
  GeoHash geoHash = GeoHash.fromDecimalDegrees(firstLocation.longitude, firstLocation.latitude);
  CoordModel coordModel = new CoordModel(firstLocation.longitude, firstLocation.latitude, geoHash.geohash);

  return coordModel;
}

// Turn the location values into a JSON format map to store in firebase
Map<String, dynamic> createCoordMap(CoordModel coordModel) {
  Map<String, dynamic> location = {
    'location': {
      "geohash": coordModel.geohash,
      "geopoint": GeoPoint(coordModel.latitude, coordModel.longitude)
    }
  };
  print("Coord map added to database");
  return location;
}