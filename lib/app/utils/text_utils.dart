import 'package:flutter/material.dart';

class TextUtils {
  static Text buildTextWidget(String text, double fntsize, Color color,
      [FontWeight? fontWeight]) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fntsize,
        fontFamily: 'Poppins',
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
