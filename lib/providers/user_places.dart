import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places_to_visit/helpers/db_helper.dart';
import 'package:places_to_visit/helpers/location_helper.dart';

import '../models/place.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String title, File pickedImage, PlaceLocation _pickedLocation) async {
    final address = await LocationHelper.selectedLocationAddressRequest(
        _pickedLocation.latitude, _pickedLocation.longitude);
    final updateLocation = PlaceLocation(
        latitude: _pickedLocation.latitude,
        longitude: _pickedLocation.longitude,
        address: address);

    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      location: updateLocation,
      title: title,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location!.latitude,
        'loc_lng': newPlace.location!.longitude,
        'address': newPlace.location!.address!,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((place) => Place(
              id: place["id"],
              title: place["title"],
              location: PlaceLocation(
                latitude: place['loc_lat'],
                longitude: place['loc_lng'],
                address: place['address'],
              ),
              image: File(place['image']),
            ))
        .toList();
    notifyListeners();
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }
}

//----


