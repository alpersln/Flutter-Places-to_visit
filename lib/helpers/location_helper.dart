import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/*
var asd = DotEnv().env['MAPBOX_API_KEY'];

var dds = DotEnv().env['ADDRESS_API_KEY'];

const MAPBOX_API_KEY =
    "pk.eyJ1IjoiZGlzdGlycSIsImEiOiJjbDFrenJjMDEwMDJtM2lwbWlqdTgzeTJ6In0.WjEAZ0MsWr9bPUDZ_oaR_A";

const ADDRESS_API_KEY = "c4b513670b1fd6ab6b73d4cf522837ca";
*/
var MapBox = dotenv.env['MAPBOX_API_KEY'];
var Adress = dotenv.env['ADDRESS_API_KEY'];

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MapBox';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$lat,$lng.json?access_token=$MapBox');
    final response = await http.get(url);
    return json.decode(response.body)['features'][0]['place_name'];
  }

  static Future<String> selectedLocationAddressRequest(
      double lat, double lng) async {
    final url = Uri.parse(
        'http://api.positionstack.com/v1/reverse?access_key=$Adress&query=$lat,$lng');
    final response = await http.get(url);
    return json.decode(response.body)['data'][0]['label'];
  }
}
