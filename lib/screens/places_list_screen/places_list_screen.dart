import 'package:flutter/material.dart';
import 'package:places_to_visit/screens/add_place_screen/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Places List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/addPlaceSc');
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
