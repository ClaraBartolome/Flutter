import 'package:flutter/material.dart';
import 'package:go_moon/widgets/custom_dropdown_button.dart';

class HomePage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: Container(
      height: _deviceHeight,
      width: _deviceWidth,
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_pageTitle(), _bookRide()],
          ),
          Align(
            alignment: Alignment.center,
            child: _moonImageWidget(),
          )
        ],
      )
    )));
  }

  Widget _bookRide() {
    return Container(
      height: _deviceHeight * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _destinationDropDown(),
          _travelersInformationDropDown(),
          _rideButton()
        ],
      ),
    );
  }

  Widget _destinationDropDown() {
    return CustomDropDownButtonClass(
        values: const ["Clara Bartolomé", "Astrid Mornigstar", "Cordelia Lynch"], width: _deviceWidth);
  }

  Widget _travelersInformationDropDown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomDropDownButtonClass(
            values: const ["Earth", "Mercury", "Mars"],
            width: _deviceWidth * 0.4),
        CustomDropDownButtonClass(
            values: const ["First Class", "Business", "Economy"],
            width: _deviceWidth * 0.4)
      ],
    );
  }

  Widget _rideButton() {
    return Container(
      width: _deviceWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.only(bottom: _deviceHeight * 0.01),
      child: MaterialButton(
        onPressed: () {},
        child: Text("Book ride!",
        style: TextStyle(
          color: Colors.black
        ),),
      ),
    );
  }

  Widget _moonImageWidget() {
    return Container(
      height: _deviceHeight * 0.6,
      width: _deviceWidth * 0.75,

      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/moon.png'), fit: BoxFit.fitWidth)),
    );
  }
}

Widget _pageTitle() {
  return const Text(
    "Go Moon",
    style: TextStyle(
        color: Colors.white, fontSize: 70, fontWeight: FontWeight.w500),
  );
}

