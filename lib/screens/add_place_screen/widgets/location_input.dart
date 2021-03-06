import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:places_to_visit/helpers/location_helper.dart';
import 'package:places_to_visit/models/place.dart';
import 'package:places_to_visit/screens/map_screen/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;
  const LocationInput(this.onSelectLocation, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _showPreview(double latitude, double longitude) async {
    final previewUrl = LocationHelper.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
    );
    setState(() {
      _previewImageUrl = previewUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();

    _showPreview(locationData.latitude!, locationData.longitude!);
    widget.onSelectLocation(locationData.latitude, locationData.longitude);
  }

  /* Future<void> _selectOnMap() async {
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => MapScreen(
        isSelecting: true,
      ),
    ));

    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectLocation(
        selectedLocation.latitude, selectedLocation.longitude);
  } */

  LatLng? loc;
  Future<void> _selectOnMap() async {
    //   final locationData = await Location().getLocation();
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => MapScreen(
        isSelecting: true,
        initialLocation: loc != null
            ? PlaceLocation(latitude: loc!.latitude, longitude: loc!.longitude)
            : const PlaceLocation(
                latitude: 38.3771515281, longitude: 27.124763293),
      ),
    ));

    if (selectedLocation == null) {
      return;
    }
    setState(() {
      loc = selectedLocation;
    });
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectLocation(
        selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(12)),
          width: double.infinity,
          height: 200,
          child: _previewImageUrl == null
              ? const Text(
                  "No location chosed",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: Icon(Icons.location_on_outlined),
                label: Text("Current Location")),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: Icon(Icons.map_outlined),
                label: Text("Select on Map")),
          ],
        )
      ],
    );
  }
}
