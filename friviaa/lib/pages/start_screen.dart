import 'package:flutter/material.dart';
import 'package:friviaa/components/customText.dart';

import '../components/customMaterialButton.dart';
import '../constants/constants.dart';

class StartScreen extends StatefulWidget {

  void Function(double)? onClickButton;
  StartScreen({
    required this.onClickButton});

  @override
  State<StatefulWidget> createState() {
    return _startScreen(onClickButton: onClickButton);
  }
}

class _startScreen extends State {
  double? _deviceHeight, _deviceWidth;
  double _sliderCurrentValue = 0;

  void Function(double)? onClickButton;
  _startScreen({
    required this.onClickButton});


  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            customText(text: titleGame, fontSize: 40),
            customText(text: difficultyList[_sliderCurrentValue.round()], fontSize: 20)
          ],
        ),
        Slider(
            value: _sliderCurrentValue,
            divisions: 2,
            max: 2,
            label: difficultyList[_sliderCurrentValue.round()],
            activeColor: Colors.blue,
            thumbColor: Colors.blue,
            onChanged: (double value) {
              setState(() {
                _sliderCurrentValue = value;
              });
            }),
        Column(
          children: [
            SizedBox(height: _deviceHeight! * 0.01),
            customMaterialButton(
                minWidth: _deviceWidth! * 0.8,
                height: _deviceHeight! * 0.1,
                onPressed:(){onClickButton!(_sliderCurrentValue);},
                buttonText: "Start",
                color: Colors.blue)
          ],
        )
      ],
    );
  }
}
