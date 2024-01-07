import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBubble extends StatelessWidget {
  TextBubble({
    super.key,
    required this.inputText,
    this.bubbleColour = const Color.fromARGB(255, 245, 241, 233),
    this.textBubbleAlign = TextAlign.center,
    this.textColour = Colors.black,
    this.borderRadius = 10.0,
    this.textFontSize = 14.0,
  });
  String inputText;
  TextAlign textBubbleAlign;
  Color bubbleColour;
  Color textColour;
  double borderRadius;
  double textFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.0,
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: bubbleColour,
      ),
      child: Text(
        inputText,
        textAlign: textBubbleAlign,
        style: GoogleFonts.openSans(
          textStyle: TextStyle(
            color: textColour,
            fontSize: textFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
