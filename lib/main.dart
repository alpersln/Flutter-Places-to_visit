import 'package:flutter/material.dart';
import 'package:places_to_visit/providers/theme_provider.dart';

import 'package:places_to_visit/providers/user_places.dart';
import 'package:places_to_visit/screens/add_place_screen/add_place_screen.dart';
import 'package:places_to_visit/screens/place_detail_screen/place_detail_screen.dart';
import 'package:places_to_visit/screens/places_list_screen/places_list_screen.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
    child: MyApp(),
    create: (context) => ThemeProvider(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeManager.createTheme(AppThemeLight()),
        darkTheme: ThemeManager.createTheme(AppThemeDark()),
        themeMode: Provider.of<ThemeProvider>(context, listen: false).themeMode,
        home: const PlacesListScreen(),
        routes: {
          '/addPlaceSc': (ctx) => const AddPlaceScreen(),
          '/placeDetailSc': (ctx) => const PlacesDetailScreen(),
        },
      ),
    );
  }
}
