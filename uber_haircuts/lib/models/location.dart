class LocationModel {
  final String placeId;
  final String description;

  LocationModel(this.placeId, this.description);


  String locationToString() {
    return 'LocationModel(description: $description, placeId: $placeId)';
  }
}

class CoordModel {
  final double longitude;
  final double latitude;
  final String geohash;

  CoordModel(this.longitude, this.latitude, this.geohash);
}

class PlaceModel {
  String number;
  String street;
  String city;
  String postcode;

  PlaceModel({
    this.number,
    this.street,
    this.city,
    this.postcode,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $number, street: $street, city: $city, zipCode: $postcode)';
  }
}