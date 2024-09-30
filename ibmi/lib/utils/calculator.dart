import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

double calculateBMI(int height, int weight){
  return (weight / pow(height / 100, 2));
}

Future<double> calculateBMIAsync(Dio dio) async{
  var result = await dio.get('');
  var data = result.data;
  var bmi = calculateBMI(data["Sergio Ramos"][0], data["Sergio Ramos"][1]);
  return bmi;
}