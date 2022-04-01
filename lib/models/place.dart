import 'dart:io';

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place(this.id, this.title, this.location, this.image);
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation(this.address,
      {required this.latitude, required this.longitude});
}
