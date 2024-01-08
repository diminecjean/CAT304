
import 'package:flutter/material.dart';

class Style {
  static TextStyle cancelButtonTextStyle() {
    return const TextStyle(fontSize: 16, color: Colors.black54);
  }

  static TextStyle acceptButtonTextStyle() {
    // ignore: prefer_const_constructors
    return TextStyle(fontSize: 16, color: Colors.indigo);
  }

  static ButtonStyle cancelButtonStyle() {
    return ElevatedButton.styleFrom(backgroundColor: Colors.grey[100]);
  }

  static ButtonStyle acceptButtonStyle() {
    return ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 17, 87, 21));
  }

  static TextStyle pageName() {
    return const TextStyle(
        fontSize: 25, color: Color.fromARGB(255, 255, 255, 255));
  }
}
