import 'dart:io';
import 'package:path_provider/path_provider.dart' as system_paths;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:places_to_visit/screens/add_place_screen/add_place_screen.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takepicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    // print("${imageFile.toString()}");   //instance of XFile
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDirectory = await system_paths
        .getApplicationDocumentsDirectory(); // get the default directory of this
    // print("${appDirectory}");                            //    a/b/c

    final fileName = path.basename(imageFile.path);
    //  print("${fileName}");                               //    /d.jpg

    final savedImage = await File(imageFile.path).copy(
        "${appDirectory.path}/$fileName"); //get the filename stored in temporary storage along with path and copy to savedImage
    // print("${savedImage}");                               //a/b/c/d.jpg

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Take Picture'),
            onPressed: _takepicture,
          ),
        ),
      ],
    );
  }
}
