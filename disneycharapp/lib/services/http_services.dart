import 'package:dio/dio.dart';
import 'package:coincap/models/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class HttpService{
  final Dio dio = Dio();

  AppConfig? appConfig;
  String? baseUrl;

  HttpService(){
    appConfig = GetIt.instance.get<AppConfig>();
    baseUrl = appConfig!.DISNEY_API_BASE_URL;
    if (kDebugMode) {
      print("HTTP SERVICES: $baseUrl");
    }
  }
  Future<Response?> get(String path) async{
    try{
      String url = "$baseUrl$path";
      print("URL: $url");
      //FOR QUERIES dio.get(url, queryParameters: {"name":"Hercules"});
      Response? response = await dio.get(url);
      print("RESPONSE: $response");
      return response;
    }catch(e){
      print("HTTP Service: Unable to perform get request");
      print("Error: $e");
    }
    return null;
  }

  Future<Response?> getCharacterByName(String path, String name,String film) async{
    try{
      String url = "$baseUrl$path";
      print("URL: $url");
      //FOR QUERIES dio.get(url, queryParameters: {"name":"Hercules"});
      Response? response = await dio.get(url, queryParameters: {"name":name, "films": film});
      print("RESPONSE: $response");
      return response;
    }catch(e){
      print("HTTP Service: Unable to perform get request");
      print("Error: $e");
    }
    return null;
  }
}