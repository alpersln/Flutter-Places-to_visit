import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

var MAPBOX_API = dotenv.env['MAPBOX_API_KEY'];
var ADDRESS_API = dotenv.env['ADDRESS_API_KEY'];

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_API';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$lat,$lng.json?access_token=$MAPBOX_API');
    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['place_name'];
  }

  static Future<String> selectedLocationAddressRequest(
      double lat, double lng) async {
    final url = Uri.parse(
        'http://api.positionstack.com/v1/reverse?access_key=$ADDRESS_API&query=$lat,$lng');
    final response = await http.get(url);
    return json.decode(response.body)['data'][0]['label'];
  }
}
