import 'dart:io';
import 'package:express_all/src/config/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:express_all/src/services/gcp_vision_api.dart';
import 'package:flutter/services.dart';

class EmotionDetectionPage extends StatefulWidget {
  const EmotionDetectionPage({Key? key}) : super(key: key);

  @override
  _EmotionDetectionPageState createState() => _EmotionDetectionPageState();
}

class _EmotionDetectionPageState extends State<EmotionDetectionPage> {
  XFile? _image;
  final api = GcpVisionApi(
      "assets/credentials/charged-kiln-411801-f5e5cdcaee01.json"); // replace with your actual path
  String? _emotionResult;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    api.initialize();
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _isLoading = true;
        });
        var imageFile = File(image.path);
        var emotionResult = await api.detectFaces(imageFile);
        if (mounted) {
          setState(() {
            _image = image;
            _emotionResult = emotionResult;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (e is PlatformException && e.code == 'already_active') {
        // Handle the exception here. You might want to show a message to the user, or log the error.
        print('Image picker is already active');
      } else {
        // Re-throw the exception if it's not the one we're expecting.
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Emotion Detection",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: primaryColor,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _image == null
                    ? Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            const Text(
                              "Upload an image to detect emotions",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Image.asset('assets/images/upload_picture.png',
                                height: 320),
                            const SizedBox(height: 30),
                            const Text('No image selected.'),
                          ])
                    : _isLoading
                        ? const CircularProgressIndicator(
                            color: primaryColor,
                          )
                        : Column(
                            children: [
                              const Text(
                                "Your image has been uploaded successfully!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Image.file(File(_image!.path)),
                              const Text(''),
                              Text(
                                'Dominant Emotion: $_emotionResult',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              const Text(''),
                            ],
                          ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                    elevation: MaterialStateProperty.all<double>(2),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: pickImage,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.upload_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                            width:
                                10), // Add some spacing between the logo and the text
                        _image == null
                            ? Text(
                                'Upload A Photo',
                                style: TextStyle(color: Colors.white),
                              )
                            : Text(
                                'Upload Another Photo',
                                style: TextStyle(color: Colors.white),
                              )
                      ],
                    ),
                  ),
                ),

                // Add more widgets here for further processing or displaying results
              ],
            ),
          ),
        ),
      ),
    );
  }
}
