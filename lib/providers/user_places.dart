import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:places_to_visit/helpers/db_helper.dart';

import '../models/place.dart';

class UserPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      location: PlaceLocation(latitude: 123.3, longitude: 23.3),
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
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((place) => Place(
              id: place["id"],
              title: place["title"],
              location: const PlaceLocation(latitude: 123.3, longitude: 23.3),
              image: File(place['image']),
            ))
        .toList();
    notifyListeners();
  }
}
