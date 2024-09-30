import 'package:flutter/material.dart';

Widget customText(
    {String key = "key",
    required String text,
    Color textColor = Colors.black,
    double fontSize = 25,
    FontWeight fontWeight = FontWeight.w400}) {
  return Text(
    //key: Key("custom_text$key"),
    text,
    style:
        TextStyle(color: textColor, fontSize: fontSize, fontWeight: fontWeight),
  );
}
