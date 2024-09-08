import 'package:flutter/material.dart';
import 'package:go_moon/pages/home_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget{
  const App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GoMoon",
      theme: myTheme(),
      home: HomePage(),
    );
  }
}

ThemeData myTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xFF151515)
  );
}

