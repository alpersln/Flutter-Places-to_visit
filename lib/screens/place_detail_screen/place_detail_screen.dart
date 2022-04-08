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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: LocationHelper.selectedLocationAddressRequest(
                    selectedPlace.location!.latitude,
                    selectedPlace.location!.longitude),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString());
                  } else {
                    return Text(snapshot.error.toString());
                  }
                }),
            Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  selectedPlace.image,
                  fit: BoxFit.cover,
                ),
              ),
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

                      // "sdsd"
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => MapScreen(
                                    isSelecting: true,
                                    initialLocation: selectedPlace.location!,
                                  )));
                        },
                        child: Text("Open Map"))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
