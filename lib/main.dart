import 'package:flutter/material.dart';
import 'package:places_to_visit/providers/user_places.dart';
import 'package:places_to_visit/screens/add_place_screen/add_place_screen.dart';
import 'package:places_to_visit/screens/places_list_screen/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
        ),
        home: const PlacesListScreen(),
        routes: {
          '/addPlaceSc': (ctx) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
