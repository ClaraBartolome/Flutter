import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/utils/calculator.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio{}

void main() {
  test('Give height and weight when calculate BMI function invoked then correct BMI returned', () async {
    //Arrange
    const int height = 180, weight = 70;
    //Act
    double bmi = calculateBMI(height, weight);
    //Assert
    expect(double.parse(bmi.toStringAsFixed(2)), 21.6);
  });

  test('Given url when calculate the bmi the correct bmi return', () async{
    final dioMock = DioMock();
    when(() => dioMock.get(''))
        .thenAnswer(
      (_) => Future.value(
        Response(
          requestOptions: RequestOptions(path: ""),
          data:
            {
              "Sergio Ramos": [180, 80]
            },
        ),
      ),
    );

    var result = await calculateBMIAsync(dioMock);
    expect(double.parse(result.toStringAsFixed(2)), 24.69);
  });


}
