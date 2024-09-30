import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ibmi/components/custom_container.dart';

import 'customText.dart';

Widget customButtonSelector({
  required String key,
  required double width,
  required double height,
  required String title,
  required int numberSelector,
  void Function()? onPressedAdd,
  void Function()? onPressedSubtract,
}) {
  return customContainer(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customText(
              text: title,
              fontSize: 15,
              fontWeight: FontWeight.w400
          ),
          customText(
            key: "_custom_button_selector_number$key",
              text: numberSelector.toString(),
              fontSize: 45,
              fontWeight: FontWeight.w700
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                    onPressed: onPressedAdd,
                    child:
                    customText(
                        text: "-",
                        textColor: Colors.red,
                        fontSize: 25,
                    )
                  )),
              SizedBox(
                  key: Key("custom_button_selector_add_button$key"),
                  width: 50,
                  child: CupertinoDialogAction(
                    onPressed: onPressedSubtract,
                    child: customText(
                      text: "+",
                      textColor: Colors.blue,
                      fontSize: 25,
                    ),
                  ))
            ],
          )
        ],
      ));
}
