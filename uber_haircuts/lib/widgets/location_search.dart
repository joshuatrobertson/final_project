import 'package:flutter/material.dart';
import 'package:uber_haircuts/helpers/google_maps.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:uber_haircuts/screens/user_gps.dart';

class ShowSearchPage extends SearchDelegate<LocationModel> {

  final sessionToken;
  GoogleMapsAPI googleMapsAPI;

  ShowSearchPage(this.sessionToken) {
    googleMapsAPI = GoogleMapsAPI(sessionToken);
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: query == ''
            ? null : googleMapsAPI.getLocations(query),
        builder: (context, snapshot) => query == '' ?
        ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title:
            Text(snapshot.data[index]),
            onTap: () {
              close(context, snapshot.data[index]);
            },
          ),
          itemCount: snapshot.data.length,
        )
            : CircularProgressIndicator);
  }
}