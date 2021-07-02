class LocationModel {
  final String placeId;
  final String description;

  LocationModel(this.placeId, this.description);


  @override
  String locationToString() {
    return 'LocationModel(description: $description, placeId: $placeId)';
  }
}