import 'package:uber_haircuts/models/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class GoogleMapsAPI {
  var client = http.Client();

  GoogleMapsAPI(this.sessionToken);

  final sessionToken;

  // Locations API key
  static final String apiKey = 'AIzaSyADHRmQGzWbsWIoebuHjFSuBPM77bIdvXs';

  Future<List<LocationModel>> getLocations(String input) async {
    // Create an api request using the session token/ api key
    final apiRequest =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&components=country:uk&lang=en&key=$apiKey&sessiontoken=$sessionToken';
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
