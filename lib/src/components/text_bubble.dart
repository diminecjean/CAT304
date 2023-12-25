import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBubble extends StatelessWidget {
  TextBubble({
    super.key,
    required this.inputText,
    required this.textBubbleAlign,
    required this.bubbleColour,
    required this.textColour,
    required this.borderRadius,
    required this.textFontSize,
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
      margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
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
