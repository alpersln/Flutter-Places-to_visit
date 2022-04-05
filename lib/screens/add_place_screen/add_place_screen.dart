import 'dart:io';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:places_to_visit/models/place.dart';
import 'package:places_to_visit/providers/user_places.dart';
import 'package:places_to_visit/screens/add_place_screen/widgets/location_input.dart';
import 'package:provider/provider.dart';

import 'widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectLocation(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return print("they are nulll");
    } else {
      Provider.of<UserPlaces>(context, listen: false)
          .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(
                      onSelectImage: _selectImage,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    LocationInput(_selectLocation),
                  ],
                ),
              ),
            ),
          ),
          TextButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: _savePlace,
          ),
        ],
      ),
    );
  }
}
