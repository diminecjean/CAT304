import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmotionDetectionPage extends StatefulWidget {
  const EmotionDetectionPage({super.key});

  @override
  _EmotionDetectionPageState createState() => _EmotionDetectionPageState();
}

class _EmotionDetectionPageState extends State<EmotionDetectionPage> {
  XFile? _image;

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emotion Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path)),
            Text(''),
            Text('Emotion: Happy'),
            Text(''),
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Upload Photo'),
            ),

            // Add more widgets here for further processing or displaying results
          ],
        ),
      ),
    );
  }
}
