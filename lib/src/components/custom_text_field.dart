import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.obscureText = false});
  String labelText;
  String hintText;
  bool obscureText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.labelText,
            hintText: widget.hintText),
      ),
    );
  }
}
