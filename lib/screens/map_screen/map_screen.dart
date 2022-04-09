import 'package:flutter/material.dart';
import 'package:places_to_visit/core/theme/color/color_theme.dart';
import 'package:places_to_visit/models/place.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../core/widgets/custom_snackbar.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 36.5847, longitude: 36.1756),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  Future<void> _selectLocation(dynamic tapPosition, LatLng position) async {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FlutterMap(
            options: MapOptions(
              onTap: widget.isSelecting ? _selectLocation : null,
              center: LatLng(widget.initialLocation.latitude,
                  widget.initialLocation.longitude),
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/distirq/cl1m3rcyc003914s5m2m5moj9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGlzdGlycSIsImEiOiJjbDFrenJjMDEwMDJtM2lwbWlqdTgzeTJ6In0.WjEAZ0MsWr9bPUDZ_oaR_A",
                additionalOptions: {
                  'accessToken':
                      "pk.eyJ1IjoiZGlzdGlycSIsImEiOiJjbDFrenJjMDEwMDJtM2lwbWlqdTgzeTJ6In0.WjEAZ0MsWr9bPUDZ_oaR_A",
                  'id': 'mapbox.mapbox-streets-v8'
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _pickedLocation ??
                          LatLng(widget.initialLocation.latitude,
                              widget.initialLocation.longitude),
                      builder: (ctx) => Icon(
                            Icons.location_pin,
                            color: AppColors().red,
                          )),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 22,
            child: ElevatedButton(
                onPressed: () {
                  _pickedLocation == null
                      ? GlobalSnackBar.show(context, "Please select location")
                      : Navigator.of(context).pop(_pickedLocation);
                },
                child: Text("Save Location")),
          ),
        ],
      ),
    );
  }
}
