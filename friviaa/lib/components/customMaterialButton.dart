import 'package:flutter/material.dart';

Widget customMaterialButton({
  required double minWidth,
  required double height,
  required void Function()? onPressed,
  required String buttonText,
  Color color = Colors.blue
}) {
  return MaterialButton(
    onPressed: onPressed,
    color: color,
    minWidth: minWidth,
    height: height,
    child: Text(buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        )),
  );
}