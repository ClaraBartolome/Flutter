import 'package:flutter/material.dart';

Widget customText({
  required String text,
  Color textColor = Colors.white,
  double fontSize = 25
}){
  return Text(text,
    style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w400
    ),);
}