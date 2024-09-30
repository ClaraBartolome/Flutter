import 'package:flutter/material.dart';

Widget customText({
  required String text,
  Color textColor = Colors.white,
  double fontSize = 25,
  FontWeight fontWeight = FontWeight.w400
}){
  return Text(text,
    style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight
    ),);
}