import 'package:e_form/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextMain extends StatelessWidget {
  const TextMain({
    Key? key,
    required this.text,
    this.size = 14,
    this.textColor = AppColor.darkText,
    this.textFontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  final String text;
  final double size;
  final Color textColor;
  final FontWeight textFontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: GoogleFonts.openSans(
            textStyle: TextStyle(
          color: textColor,
          fontSize: size,
          fontWeight: textFontWeight,
        )));
  }
}
