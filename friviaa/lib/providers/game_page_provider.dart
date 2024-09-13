import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:friviaa/components/customText.dart';
import 'package:friviaa/constants/constants.dart';
import 'package:html_unescape/html_unescape.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _questionsNumber = 10;
  List? questions;
  int _currentQuestionCount = 0;
  bool _isGameStarted = false;
  int _score = 0;
  String _difficulty = "easy";

  BuildContext buildContext;

  GamePageProvider({required this.buildContext}) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
  }

  Future<void> _getQuestionsFromAPI() async {
    var response = await _dio.get("", queryParameters: {
      "amount": _questionsNumber,
      "type": "boolean",
      "difficulty": _difficulty
    });
    var data = jsonDecode(response.toString());
    questions = data["results"];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    var unescape = HtmlUnescape();
    return unescape.convert(questions![_currentQuestionCount]["question"]);
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        questions![_currentQuestionCount]["correct_answer"] == answer;
    _currentQuestionCount +=
        (_currentQuestionCount == _questionsNumber - 1) ? 0 : 1;
    _score += isCorrect? 1 : 0;
    showDialog(
        context: buildContext,
        barrierDismissible: false,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 1),(){
      Navigator.of(buildContext).pop(true);
    });
    if (_currentQuestionCount == _questionsNumber - 1) {
      endGame();
    }else{
      notifyListeners();
    }
  }

  void endGame() async {
    showDialog(
        context: buildContext,
        barrierDismissible: false,
        builder: (BuildContext _context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: customText(text: "Endgame"),
            content: customText(text: "Score: $_score", fontSize: 15),
          );
        });
    await Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(buildContext).pop(true);
    });
    _isGameStarted = false;
    _currentQuestionCount = 0;
    _score = 0;
    notifyListeners();
  }

  Future<void> startGame(double d) async {
    _isGameStarted = true;
    _difficulty = difficultyList[d.round()].toLowerCase();
    print(_isGameStarted);
    await _getQuestionsFromAPI();
    notifyListeners();
  }

  bool isGameStarted(){
    return _isGameStarted;
  }

  int getScore(){
    return _score;
  }

  int getCurrentQuestion(){
    return _currentQuestionCount + 1;
  }

  int getTotalQuestions(){
    return _questionsNumber;
  }

  String getDifficulty(){
    return _difficulty;
  }
}
