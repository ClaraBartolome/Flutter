import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ibmi/components/customText.dart';
import 'package:ibmi/components/custom_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  double? _deviceHeight, _deviceWidth;


  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: _dataCard()
    );
  }

  Widget _dataCard() {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (BuildContext _context, AsyncSnapshot _snapshot){
          if(_snapshot.hasData){
            final _prefs = _snapshot.data;
            final _date = _prefs.getString("bmi_date");
            final _data = _prefs.getStringList("bmi_data");
            return Center(child: customContainer(
                width: _deviceWidth! * 0.75,
                height: _deviceHeight! * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _statusText(_data![1]),
                    _dateText(_date!),
                    _bmiText(_data![0])
                  ],
                )));
          }else{
            return const Center(child: CupertinoActivityIndicator(
              color: Colors.blue,
            ),);
          }
        });
  }

  Widget _statusText(String status){
    return customText(text: status, fontSize: 30, fontWeight: FontWeight.w400);
  }

  Widget _dateText(String date){
    DateTime _parseDate = DateTime.parse(date);
    return customText(text: "${_parseDate.day} / ${_parseDate.month} / ${_parseDate.year}", fontSize: 15, fontWeight: FontWeight.w400);
  }

  Widget _bmiText(String bmi){
    return customText(text: bmi, fontSize: 60, fontWeight: FontWeight.w600);
  }
}