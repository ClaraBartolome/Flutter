import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ibmi/components/custom_button_selector.dart';
import 'package:ibmi/components/custom_container.dart';
import 'package:ibmi/utils/calculator.dart';

import '../components/customText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  double? _deviceHeight, _deviceWidth;
  int _age = 25;
  int _weight = 60;
  int _height = 165;
  int _gender = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
        child: Center(
      child: Container(
        height: _deviceHeight! * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [_ageSelector(), _weightSelector()],
            ),
            _heightSelector(),
            _genderSelector(),
            _calculateBMIButton()
          ],
        ),
      ),
    ));
  }

  Widget _ageSelector() {
    return customButtonSelector(
        key: "_age",
        width: _deviceWidth! * 0.45,
        height: _deviceHeight! * 0.2,
        title: "Age yr",
        numberSelector: _age,
        onPressedAdd: () {
          setState(() {
            _age -= 1;
          });
        },
        onPressedSubtract: () {
          setState(() {
            _age += 1;
          });
        });
  }

  Widget _weightSelector() {
    return customButtonSelector(
        key: "_weight",
        width: _deviceWidth! * 0.45,
        height: _deviceHeight! * 0.2,
        title: "Weight kg",
        numberSelector: _weight,
        onPressedAdd: () {
          setState(() {
            _weight -= 1;
          });
        },
        onPressedSubtract: () {
          setState(() {
            _weight += 1;
          });
        });
  }

  Widget _heightSelector() {
    return customContainer(
        height: _deviceHeight! * 0.15,
        width: _deviceWidth! * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customText(
              text: "Height cm",
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            customText(
              text: _height.round().toString(),
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(
              width: _deviceWidth! * 0.8,
              child: CupertinoSlider(
                  min: 0.0,
                  max: 250.0,
                  divisions: 250,
                  value: _height.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      _height = value.toInt();
                    });
                  }),
            )
          ],
        ));
  }

  Widget _genderSelector() {
    return customContainer(
        height: _deviceHeight! * 0.11,
        width: _deviceWidth! * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customText(
              text: "Gender",
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            CupertinoSlidingSegmentedControl(
                groupValue: _gender,
                children: const {
                  0: Text("Male"),
                  1: Text("Female"),
                },
                onValueChanged: (_value) {
                  setState(() {
                    _gender = _value as int;
                  });
                })
          ],
        ));
  }

  Widget _calculateBMIButton() {
    return Container(
      height: _deviceHeight! * 0.07,
      child: CupertinoButton.filled(
          child: const Text("Calculate BMI"),
          onPressed: () {
            if (_height > 0 && _weight > 0 && _age > 0) {
              double bmi = calculateBMI(_height, _weight);
              print(bmi);
              _resultDialog(bmi);
            }
          }),
    );
  }

  void _resultDialog(double bmi) {
    String? _status;
    if(bmi < 18.5) {
      _status = "Underweight";
    }else if(bmi >= 18.5 && bmi < 25){
      _status = "Normal";
    }else if(bmi >= 25 && bmi < 30){
      _status = "Overweight";
    }else if(bmi >= 30){
      _status = "Obese";
    }
    showCupertinoDialog(
        context: context,
        builder: (BuildContext _context){
          return CupertinoAlertDialog(
            title: Text(_status!),
            content: Text(bmi.toStringAsFixed(2)),
            actions: [
              CupertinoDialogAction(
                child: const Text("Ok"),
                onPressed: () {
                  _saveResult(bmi.toStringAsFixed(2), _status!);
                  Navigator.pop(_context);
                },)
            ],
          );
        });
  }

  void _saveResult(String bmi, String status) async{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("bmi_date", DateTime.now().toString());
      await prefs.setStringList("bmi_data", <String>[bmi, status]);
      print("Results saved");
  }
}
