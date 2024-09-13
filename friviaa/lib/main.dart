import 'package:flutter/material.dart';
import 'package:friviaa/pages/game_page.dart';
import 'package:friviaa/pages/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      theme: ThemeData(
        fontFamily: "ArchitectsDaughter",
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
            surface: Colors.black45,
            onSurface: Colors.white),
            scaffoldBackgroundColor: Colors.grey.shade900,
            useMaterial3: true,
      ),
      home: GamePage(),
    );
  }
}
