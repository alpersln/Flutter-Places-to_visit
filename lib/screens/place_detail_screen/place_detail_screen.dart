import 'package:flutter/material.dart';
import 'package:places_to_visit/screens/map_screen/map_screen.dart';
import 'package:provider/provider.dart';

import '../../helpers/location_helper.dart';
import '../../providers/user_places.dart';

class PlacesDetailScreen extends StatelessWidget {
  const PlacesDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace =
        Provider.of<UserPlaces>(context, listen: false).findById(id.toString());
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Image.file(selectedPlace.image),
          ),
          SizedBox(
            height: 12,
          ),
          Text(selectedPlace.title),
          Text(selectedPlace.location!.latitude.toString()),
          SizedBox(
            height: 12,
          ),
          Text(selectedPlace.location!.address ?? "address"),
          Container(
              height: 250,
              width: 250,
              child: Stack(
                children: [
                  Image.network(
                    LocationHelper.generateLocationPreviewImage(
                      latitude: selectedPlace.location!.latitude,
                      longitude: selectedPlace.location!.longitude,
                    ),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => MapScreen(
                                  initialLocation: selectedPlace.location!,
                                )));
                      },
                      child: Text("Open Map"))
                ],
              ))
        ],
      ),
    );
  }
}
