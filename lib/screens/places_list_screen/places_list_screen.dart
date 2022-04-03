import 'package:flutter/material.dart';
import 'package:places_to_visit/screens/add_place_screen/add_place_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/user_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var placesItem = Provider.of<UserPlaces>(context).items;
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
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(12),
              child: Consumer<UserPlaces>(
                child: Center(child: Text("no places yet")),
                builder: (ctx, userPlaces, ch) => userPlaces.items.length <= 0
                    ? ch!
                    : ListView.builder(
                        itemCount: userPlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(userPlaces.items[i].image)),
                              title: Text(userPlaces.items[i].title),
                              onTap: () {
                                //detail
                              },
                            )),
              ))),
    );
  }
}