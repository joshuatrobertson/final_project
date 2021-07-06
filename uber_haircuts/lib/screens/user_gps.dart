// Documentation here - https://developers.google.com/maps/documentation/places/web-service/autocomplete
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:uber_haircuts/widgets/categories_filter.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../common_items.dart';

final _controller = TextEditingController;

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
                onTap: () async {
                  showSearch(
                    context: context,
                    delegate: ShowSearchPage(),
                  );
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
    return StreamBuilder(
      builder: (context, snapshot) => query == ''
          ? Container(
      )
          : snapshot.hasData
          ? ListView.builder(
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

  GoogleMapsAPI(this.sessionToken, this.client);

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
  
}
