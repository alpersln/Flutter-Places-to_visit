import 'package:flutter/material.dart';
import 'package:places_to_visit/core/theme/color/color_theme.dart';
import 'package:places_to_visit/screens/map_screen/map_screen.dart';
import 'package:provider/provider.dart';

import '../../helpers/location_helper.dart';
import '../../providers/user_places.dart';

class PlacesDetailScreen extends StatelessWidget {
  const PlacesDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    bool isLoading;
    final selectedPlace =
        Provider.of<UserPlaces>(context, listen: false).findById(id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //   padding: const EdgeInsets.all(10),
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
              Text(
                selectedPlace.title,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Address: ${selectedPlace.location!.address ?? "Unidentified Location"}",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 4,
              ),
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        LocationHelper.generateLocationPreviewImage(
                          latitude: selectedPlace.location!.latitude,
                          longitude: selectedPlace.location!.longitude,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => MapScreen(
                                      isSelecting: false,
                                      initialLocation: selectedPlace.location!,
                                    )));
                          },
                          child: Text(
                            "See On Map",
                            style: TextStyle(color: AppColors().white),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Latitude: ${selectedPlace.location!.latitude.toString()} ",
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                "Longitude: ${selectedPlace.location!.longitude.toString()} ",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
