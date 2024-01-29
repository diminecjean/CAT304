import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:express_all/src/services/gcp_vision_api.dart';

class EmotionDetectionPage extends StatefulWidget {
  const EmotionDetectionPage({Key? key}) : super(key: key);

  @override
  _EmotionDetectionPageState createState() => _EmotionDetectionPageState();
}

class _EmotionDetectionPageState extends State<EmotionDetectionPage> {
  XFile? _image;
  final api = GcpVisionApi("assets/credentials/charged-kiln-411801-f5e5cdcaee01.json"); // replace with your actual path
  String? _emotionResult;

  @override
  void initState() {
    super.initState();
    api.initialize();
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      var imageFile = File(image.path);
      _emotionResult = await api.detectFaces(imageFile);
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotion Detection'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(File(_image!.path)),
              const Text(''),
              Text('Emotion: $_emotionResult'),
              const Text(''),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text('Upload Photo'),
              ),
              // Add more widgets here for further processing or displaying results
            ],
          ),
        ),
      ),
    );
  }
}
