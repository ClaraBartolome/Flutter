import 'package:flutter/material.dart';

Widget customContainer({
  required double width,
  required double height,
  required Widget child,
}){
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 5)
        ]
    ),
    child: child,
  );
}