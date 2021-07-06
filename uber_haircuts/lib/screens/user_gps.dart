// Documentation here - https://developers.google.com/maps/documentation/places/web-service/autocomplete
// Created following a guide found at https://medium.com/comerge/location-search-autocomplete-in-flutter-84f155d44721
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:uber_haircuts/widgets/categories_filter.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../common_items.dart';
import 'package:uuid/uuid.dart';

class UserGPS extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        body: FireMap(),
      )
    );
  }
}

class FireMap extends StatefulWidget {

  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  @override
  final _textController = TextEditingController();
  String _number = '';
  String _street = '';
  String _city = '';
  String _postcode = '';

  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(initialCameraPosition: CameraPosition(
          target: LatLng(51.529395551477165, -0.5769402978782877),
          zoom: 2,
          )
        ),
        SizedBox(height: 5,),
        // Search bar
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: lightGrey,
                  width: 2
              ),
              borderRadius: BorderRadius.circular(14),
              color: lightGrey,
            ),
            child: ListTile(
              title: TextField(
                controller: _textController,
                onTap: () async {
                  var sessionToken = Uuid().v4();
                  // Create a search result using ShowSearchPage and put into the delegate
                  final LocationModel searchResult = await showSearch(
                    context: context,
                    delegate: ShowSearchPage(sessionToken),
                  );
                  final placeDetails = await GoogleMapsAPI(sessionToken)
                      .getLocationDetails(searchResult.placeId);
                  setState(() {
                    _textController.text = searchResult.description;
                    _number = placeDetails.number;
                    _street = placeDetails.street;
                    _city = placeDetails.city;
                    _postcode = placeDetails.postcode;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Enter your address",
                  border: InputBorder.none
                ),
              ),
              // Add the search icon and colour according to the theme
              leading: Icon(Icons.search, color: accent_1, size: 25),
            ),
          ),
        ),
      ],
    );
  }
}

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

class GoogleMapsAPI {
  var client = http.Client();

  GoogleMapsAPI(this.sessionToken);

  final sessionToken;

  // Locations API key
  static final String apiKey = 'AIzaSyADHRmQGzWbsWIoebuHjFSuBPM77bIdvXs';

  Future<List<LocationModel>> getLocations(String input) async {
    // Create an api request using the session token/ api key
    final apiRequest =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&components=country:ch&lang=en&key=$apiKey&sessiontoken=$sessionToken';
    // Send a get request to the server and return a response
    final response = await client.get(Uri.parse(apiRequest));
    final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // If we are returned results, put them into a list
        return result['predictions']
            .map<LocationModel>((p) => LocationModel(p['place_id'], p['description']))
            .toList();
      }
      // Successful call but no results
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      else {
        throw Exception(result['error_message']);
      }
  }

  // Used to parse the returned json file
  Future<PlaceModel> getLocationDetails(String placeId) async {
    final apiRequest =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(apiRequest));

      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
        result['result']['address_components'] as List<dynamic>;
        // build result
        final placeModel = PlaceModel();
        components.forEach((item) {
          final List type = item['types'];
          if (type.contains('street_number')) {
            placeModel.number = item['long_name'];
          }
          if (type.contains('route')) {
            placeModel.street = item['long_name'];
          }
          if (type.contains('locality')) {
            placeModel.city = item['long_name'];
          }
          if (type.contains('postal_code')) {
            placeModel.postcode = item['long_name'];
          }
        });
        return placeModel;
      }
      throw Exception(result['error_message']);

  }
  
}
