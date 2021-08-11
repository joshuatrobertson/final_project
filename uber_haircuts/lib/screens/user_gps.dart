// Created following a guide found at https://medium.com/comerge/location-search-autocomplete-in-flutter-84f155d44721 and the documentation
// which can be found here https://developers.google.com/maps/documentation/places/web-service/autocomplete
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:uber_haircuts/providers/authenticate.dart';
import 'package:uber_haircuts/providers/google_maps.dart';
import 'package:uber_haircuts/models/location.dart';
import 'package:uber_haircuts/screens/barber_home.dart';
import 'package:uber_haircuts/utilities/parent_barber_firestore.dart';
import 'package:uber_haircuts/utilities/user_firestore.dart';
import 'package:uber_haircuts/widgets/location_search.dart';
import 'package:flutter/material.dart';
import 'package:uber_haircuts/widgets/navigate.dart';
import '../theme/main_theme.dart';
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';
import 'home.dart';

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
  UserFirestore _userDatabase = new UserFirestore();
  ParentBarberFirestore _barberFirestore = new ParentBarberFirestore();
  final _textController = TextEditingController();
  Location location = new Location();
  // To get users current location to load barbers
  Position _currentPosition;
  final Geolocator geolocator = Geolocator();

  Widget build(BuildContext context) {

    final authProvider = Provider.of<Authenticate>(context);
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
                  final FirebaseAuth _auth = FirebaseAuth.instance;
                  final User _user = _auth.currentUser;
                  if (searchResult != null) {
                    final placeDetails = await GoogleMapsAPI(sessionToken)
                        .getLocationDetails(searchResult.placeId);
                    Map<String, dynamic> values = authProvider.createLocationMap(placeDetails);
                    // Add to the barber or user document within the database and navigate to the respective home pages
                    if (authProvider.currentUser == CurrentUser.CUSTOMER) {
                      _userDatabase.addLocationDetails(values, _user.uid);
                      navigateToScreen(context, Home());
                    }
                    else {
                      _barberFirestore.addLocationDetails(values, _user.uid);
                      navigateToScreen(context, BarberHome());
                    }

                  }
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





