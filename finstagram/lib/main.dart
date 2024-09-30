import 'package:finstagram/pages/home_page.dart';
import 'package:finstagram/pages/login_page.dart';
import 'package:finstagram/pages/register_page.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDlfRSHvxXMjLfzeeJnoK52U7JSvc7J1H4',
        appId: '1:719919471610:android:94eaec3ebab28a85ae2243',
        messagingSenderId: '719919471610',
        projectId: 'finstagram-4433c',
        storageBucket: 'finstagram-4433c.appspot.com',
      )
    );
    GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
    print("Firebase Initialized");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finstagram',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      initialRoute: "login",
      routes: {
        "register": (context) => RegisterPage(),
        "login": (context) => LoginPage(),
        "homePage": (context) => HomePage(),
      },
    );
  }
}

