import 'package:express_all/src/config/style/constants.dart';
import 'package:flutter/material.dart';

class emotionGestureRecognitionPage extends StatelessWidget {
  const emotionGestureRecognitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Facial Expression
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/FacialExpression");
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    leading: Image.asset(
                      'assets/images/emotion_gesture_recognition/facial_expression-2.png',
                    ),
                    title: const Text(
                      'Facial Expression Identification Practice',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                    subtitle: const Text(
                      "Enhance your child's ability to recognize and understand facial expressions.",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Task Sequencing
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/GestureRecognition");
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    leading: Image.asset(
                      'assets/images/emotion_gesture_recognition/gesture_recognition-2.png',
                    ),
                    title: const Text(
                      'Gesture and Body Language Exercise',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                    subtitle: const Text(
                      'Understanding gestures and body language to improve social interactions',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
