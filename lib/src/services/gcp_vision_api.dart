import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Api {
  // Path of the input image file
  final File inputImage;

  Api({required this.inputImage});

  // Converts image to base64 and calls the postVision method
  Future<String> detectFaces() async {
    String base64Image = base64Encode(await inputImage.readAsBytes());
    return await postVision(base64Image);
  }

  // Posts image to Google Cloud Vision API for face detection
  Future<String> postVision(String base64Image) async {
    // API url and key
    String apiUrl = 'https://vision.googleapis.com/v1/images:annotate';
    String apiKey = '75691527309-3r7guihu3fbq2oppen7jtcek2ne76sc3.apps.googleusercontent.com';
    // Header
    Map<String, String> headers = {'Content-Type': 'application/json'};

    // Body
    var body = json.encode({
      "requests": [
        {
          "image": {
            "content": base64Image
          },
          "features": [
            {
              "type": "FACE_DETECTION",
              "maxResults": 10
            }
          ]
        }
      ]
    });

    // Make POST request
    http.Response resp = await http.post(
      Uri.parse('$apiUrl?key=$apiKey'),
      headers: headers,
      body: body,
    );

    // Check for errors
    if (resp.statusCode != 200) {
      throw Exception('API request failed with status: ${resp.statusCode}');
    }

    // Process the response
    var result = json.decode(resp.body);
    if (result['responses'][0]['faceAnnotations'] != null) {
      var faces = result['responses'][0]['faceAnnotations'];
      String emotions = processFaces(faces);
      return emotions;
    } else {
      throw Exception('No faces detected or an error occurred');
    }
  }

  // Processes the face annotations to extract emotion likelihoods and face bounds
  String processFaces(List<dynamic> faces) {
    const likelihoodName = [
      "UNKNOWN",
      "VERY_UNLIKELY",
      "UNLIKELY",
      "POSSIBLE",
      "LIKELY",
      "VERY_LIKELY",
    ];

    StringBuffer buffer = StringBuffer();
    buffer.writeln("Faces:");
    for (var face in faces) {
      buffer.writeln("anger: ${likelihoodName[face['angerLikelihood']]}");
      buffer.writeln("joy: ${likelihoodName[face['joyLikelihood']]}");
      buffer.writeln("surprise: ${likelihoodName[face['surpriseLikelihood']]}");


      var vertices = face['boundingPoly']['vertices']
          .map((v) => "(${v['x']},${v['y']})")
          .join(",");
      buffer.writeln("face bounds: $vertices");
    }
    return buffer.toString();
  }
}
