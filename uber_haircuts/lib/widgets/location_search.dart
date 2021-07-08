import 'package:flutter/material.dart';
import 'package:uber_haircuts/providers/google_maps.dart';
import 'package:uber_haircuts/models/location.dart';

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
      future: query == ""
          ? null
          : googleMapsAPI.getLocations(
          query),
      builder: (context, snapshot) => query == ''
          ? Container(
        padding: EdgeInsets.all(16.0),
      )
          : snapshot.hasData
          ? ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title:
          Text((snapshot.data[index] as LocationModel).description),
          onTap: () {
            close(context, snapshot.data[index] as LocationModel);
          },
        ),
        itemCount: snapshot.data.length,
      )
          : Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
            child: Container(child: Text('Loading...')),
          ),
    );
  }
}