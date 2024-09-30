import 'package:flutter/material.dart';

Widget customTextForm({
  String? hintText,
  String? labelText,
  IconData? icon,
  bool obscureText = false,
  required Function(String?) onSaved,
  required String? Function(String?) validator
}){
  return TextFormField(
    obscureText: obscureText,
    decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        suffixIcon: Icon(icon, color: Colors.pink[100],),
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.pinkAccent)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.pinkAccent))),
    onSaved: onSaved,
    validator: validator,
  );
}
