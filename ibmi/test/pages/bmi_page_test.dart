import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/pages/bmi_page.dart';

void main() {
  testWidgets(
      "Given user on BMI page when user click plus button in weight info card then weight increments by one",
      (WidgetTester tester) async {
    await tester.pumpWidget(const CupertinoApp(
      home: BMIPage(),
    ));
    var weightIncrementingButton =
        find.byKey(const Key("custom_button_selector_add_button_weight"));

    await tester.tap(weightIncrementingButton);
    await tester.pump();

    var text = find.byKey(const Key("custom_text_custom_button_selector_number_weight"));
    expect(text, findsOneWidget);
  });
}