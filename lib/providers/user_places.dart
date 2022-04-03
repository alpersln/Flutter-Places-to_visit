import 'dart:io';

import 'package:flutter/foundation.dart';

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
      location:
          PlaceLocation("this is address", latitude: 123.3, longitude: 23.3),
      title: title,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}