import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:uber_haircuts/widgets/categories_filter.dart';
import 'package:uber_haircuts/widgets/return_text.dart';
import 'package:flutter/material.dart';

import '../common_items.dart';


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
        )),
        SizedBox(height: 5,),
        // Search bar
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: theme,
                  width: 3
              ),
              borderRadius: BorderRadius.circular(14),
              color: lightGrey,
            ),
            child: ListTile(
              title: TextField(
                onTap: () async {
                  showSearch(
                    context: context,
                    // we haven't created AddressSearch class
                    // this should be extending SearchDelegate
                    delegate: ShowSearchPage(),
                  );
                },
                decoration: InputDecoration(
                  hintText: "Enter your address",
                  border: InputBorder.none,
                ),
                // Add search text to the search bar and remove the border
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
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }

}
