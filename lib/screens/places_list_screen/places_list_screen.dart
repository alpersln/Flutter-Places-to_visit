import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:places_to_visit/providers/theme_provider.dart';
import 'package:places_to_visit/screens/add_place_screen/add_place_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/user_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*     final themeProvider = Provider.of<ThemeProvider>(context);
    var isDark = themeProvider.isDarkmode; */
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Places List",
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/addPlaceSc');
              },
              icon: const Icon(Icons.add)),
          DayNightSwitcher(
            isDarkModeEnabled: themeProvider.isDarkMode,
            onStateChanged: (val) {
              final provider =
                  Provider.of<ThemeProvider>(context, listen: false);
              provider.toggleTheme(val);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<UserPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<UserPlaces>(
                child: const Center(child: Text("no places yet")),
                builder: (ctx, userPlaces, ch) => userPlaces.items.length <= 0
                    ? ch!
                    : ListView.builder(
                        itemCount: userPlaces.items.length,
                        itemBuilder: (ctx, i) => Card(
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(userPlaces.items[i].image)),
                            title: Text(userPlaces.items[i].title),
                            subtitle:
                                Text(userPlaces.items[i].location!.address!),
                            onTap: () {
                              Navigator.of(context).pushNamed('/placeDetailSc',
                                  arguments: userPlaces.items[i].id);
                            },
                          ),
                        ),
                      )
                /*   
                  ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                FileImage(userPlaces.items[i].image)),
                        title: Text(userPlaces.items[i].title),
                        subtitle: Text(userPlaces.items[i].location!.address!),
                        onTap: () {
                          Navigator.of(context).pushNamed('/placeDetailSc',
                              arguments: userPlaces.items[i].id);
                        },
                      ),
                      ),*/
                ),
      ),
    );
  }
}
