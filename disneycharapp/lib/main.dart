import 'dart:convert';

import 'package:coincap/models/app_config.dart';
import 'package:coincap/pages/home_pages.dart';
import 'package:coincap/services/http_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHTTPService();
  runApp(const MyApp());
}

Future<void> loadConfig() async{
  String configContent = await rootBundle.loadString("assets/config/main.json");
  Map configData = jsonDecode(configContent);
  if (kDebugMode) {
    print(configData);
  }
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(DISNEY_API_BASE_URL: configData["DISNEY_API_BASE_URL"])
  );
}

void registerHTTPService(){
  GetIt.instance.registerSingleton<HttpService>(
    HttpService()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DisneyCharApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlue,
        primaryColor: Colors.lightBlueAccent,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

