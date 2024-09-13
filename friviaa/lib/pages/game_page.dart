import 'package:flutter/material.dart';
import 'package:friviaa/components/customMaterialButton.dart';
import 'package:friviaa/components/customText.dart';
import 'package:friviaa/components/progressIndicator.dart';
import 'package:friviaa/pages/start_screen.dart';
import 'package:friviaa/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget{
  double? _deviceHeight, _deviceWidth;
  GamePageProvider? _pageProvider;
  final String trueTitle = "True";
  final String falseTitle = "False";

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
        create: (_context) => GamePageProvider(buildContext: context), child: _buildUI());
  }

  Widget _buildUI() {
    return Builder(builder: (_context){
      _pageProvider = _context.watch<GamePageProvider>();
        return Scaffold(
          body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
                child: _pageProvider!.isGameStarted()
                  ? (_pageProvider?.questions != null) ? _gameUI() : customProgressIndicator()
                  : StartScreen(onClickButton: (double _d) {
                      _pageProvider?.startGame(_d);
                    }),
              )),
        );
    },);
  }

  Widget _gameUI() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customText(text: "Score: ${_pageProvider!.getScore()}"),
                customText(text: "Question: ${_pageProvider!.getCurrentQuestion()}/ ${_pageProvider!.getTotalQuestions()}")
              ],
            ),
            customText(text: "Difficulty: ${_pageProvider!.getDifficulty()}"),
          ],
        ),
        customText(text: _pageProvider!.getCurrentQuestionText()),
        Column(
          children: [
            customMaterialButton(
                minWidth: _deviceWidth! * 0.8,
                height: _deviceHeight! * 0.1,
                onPressed: (){ _pageProvider?.answerQuestion(trueTitle);},
                buttonText: trueTitle,
                color: Colors.green),
            SizedBox(height: _deviceHeight! * 0.01),
            customMaterialButton(
                minWidth: _deviceWidth! * 0.8,
                height: _deviceHeight! * 0.1,
                onPressed: (){ _pageProvider?.answerQuestion(falseTitle);},
                buttonText: falseTitle,
                color: Colors.red),
            SizedBox(height: _deviceHeight! * 0.1),
          ],
        )
      ],
    );
  }
}
