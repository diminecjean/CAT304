import 'dart:io';
import 'package:googleapis/vision/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'dart:convert';

class GcpVisionApi {
  final String _credentialsPath;
  VisionApi? _visionApi;

  GcpVisionApi(this._credentialsPath);

  Future<void> initialize() async {
    final credentials = ServiceAccountCredentials.fromJson(jsonEncode(
      {
        "type": "service_account",
        "project_id": "charged-kiln-411801",
        "private_key_id": "f5e5cdcaee0160038ce1119ec73ad31274658247",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEugIBADANBgkqhkiG9w0BAQEFAASCBKQwggSgAgEAAoIBAQDV8P3VWO3ijo+2\n0yxUOTtBWQZciYvAdtKQ13J6YNdSNhdPwWoD1l1WUOF73pL8ItsmVIPX7wFBw1Ui\n/aFAT/tq1JPYwJ4QhpZzHBcQQfW4WOAhLemk2Cr7OHJ0OgEjLHHi3h3uq5mKPZCY\nTD4oR5ChzdSDydQaOnk7gPDlNuyECDeCen0xGTpRkWehwRwTSp6nyVI7/Y54FMyR\nGCrNu+gdcfznO9hE+bLdjwieUgMIHP+Dc403l+vbHqCFP8SGPE/VT6zVHN5u+yYL\nNZUa8xC7lOn2M/xHd5NPtzS67+XiTB11WzWSnQyYlQe7pHsobPX4vkZmbtoyqFhr\n5x84EdYzAgMBAAECgf8PJp5hgkTRwdUM1mLpufRzlJNLyvaar3C1THm3Q+uJ/p/9\nVoqFi6QQhwigUAsrs4Udb20DStITE9Bzrqh1p98OhxJjHJZN9B2ghIdpdKqrCWda\nuUk2JboU6obkoUnul07hs+woXmb3vVrtIlMxmgXFScAdI2IWGpw46yZdFTYTBwtv\noxKZXSDF9+7tL23S+CHEp4QN4I6W78/pfKpBPir1fZzIZV8EkgDQTcvJy5cA3GZm\n0c7pOAELicu0a7WGvEVOWraG8tFSCn4Gj8ocAqxpu0SAEwfWYlbumX1rSutSVdHR\nU2DsJ6nSGfBzOjvIH5M6tie5IMcqntWfV2pSccECgYEA8x5z900LK6pAzByFoBYr\n26ZcCfHtAjnU4+8ji+liOTBa9VSHIhlD7ycSw6sMkNHD3wKbAzkhbCOUhRQCTCql\n3VSy4eXshITz7RxyZo/J2dymzF0PqBn9lMuVW7yVz4VRzsKJjj/h17EEjZvcC3kS\nlRCKkmRH8/M7eLEPmbxIqcECgYEA4UbJu9Lo20u80t7Rh1yxjn4J09tlRRBQuVhv\nvXib4v1rAZ6dnkjG/MlsE4jcvX0fZPeZsZ9r7kNcw4yEPkUZLraLQ9kI9zHXqPTM\nl1bPtkCAF7XI5Lh8doWDs5kWSlr0ISG7RSiuOjeBCgCqIA/Fx+xCq4RMRsNX8PVI\n/6T9tPMCgYAxVpjKM0R1FBQaWB92IYm9BcHf8szaisn9h+Z62l4opPuQlhrmfKIg\nwpk4RFpEeY16kJjMyqdRvtbBOxJMSstmY236EiMxsZmfIQrGbZ/VKsZe6vPmdX/U\n1ov1FgyBFNlJUImB6Mz4bOAzrNG3MlbnEXhNxTQk+dOz5pr35BILAQKBgBjNAUKT\nSp1x7hzM+QZM9yM3zv8q5TBARpLRIKQcVhUcTx6Dhti5LGcCCcrww1R9JOqps5rx\ncSFu+xRwMNLmKoqRAC39A9aq/xITuT5kCUQIP9Hcanx7rwAhXMl17hVLhBrtqr9H\nZj70g1lFj3UuJ1kGMqTNUNRthw35AwtZ77BvAoGAYbMVcnvV/ihB8E03YhwltF5m\noiyN34WuO8kdvLpOSoEM04z1nDwfUGzD1+b+g7I6cSxUrt5Aec484xD9JnkmrBtd\nMb5gO/78nUMivQJs62Xywe75qgiuYiShVT2tr5PVqQlSlbA8XetSEsaQJTQ8TQQA\nPdHirw4BoBLj+NDDbck=\n-----END PRIVATE KEY-----\n",
        "client_email": "cat304autistic@charged-kiln-411801.iam.gserviceaccount.com",
        "client_id": "106054620295812792907",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cat304autistic%40charged-kiln-411801.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
      ));
    final authClient = await clientViaServiceAccount(
      credentials,
      [VisionApi.cloudVisionScope],
    );
    _visionApi = VisionApi(authClient);
  }

  Future<String> detectFaces(File imageFile) async {
    if (_visionApi == null) {
      throw Exception('VisionApi not initialized. Call initialize() first.');
    }
    
    final bytes = await imageFile.readAsBytes();


    final image = Image(content: base64.encode(bytes));
    final request = AnnotateImageRequest(
      image: image,
      features: [Feature(type: 'FACE_DETECTION', maxResults: 10)],
    );
    
    final response = await _visionApi!.images.annotate(
      BatchAnnotateImagesRequest(requests: [request]),
    );

    final annotations = response.responses?.first.faceAnnotations;
    if (annotations == null || annotations.isEmpty) {
      throw Exception('No faces detected or an error occurred');
    }

    return processFaces(annotations);
  }

  String processFaces(List<FaceAnnotation> faces) {
    final buffer = StringBuffer()..writeln("Faces:");
    for (final face in faces) {
      buffer.writeln("anger: ${face.angerLikelihood}");
      buffer.writeln("joy: ${face.joyLikelihood}");
      buffer.writeln("surprise: ${face.surpriseLikelihood}");
      buffer.writeln("sorrow: ${face.sorrowLikelihood}");


      final vertices = face.boundingPoly!.vertices!
          .map((v) => "(${v.x},${v.y})")
          .join(", ");
      buffer.writeln("face bounds: $vertices");
    }
    return buffer.toString();
  }
}
