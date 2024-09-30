import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ibmi/pages/bmi_page.dart';
import 'package:ibmi/pages/history.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Widget> _tabs = [
    BMIPage(),
    HistoryPage()
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Colors.blue,
        middle: Text("IBMI", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.white),),
      ),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: "BMI"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person),
                    label: "History"),
          ]),
          tabBuilder: (BuildContext _context, int _index){
            return CupertinoTabView(
              builder: (context){
                return _tabs[_index];
              },
            );
          }),
    );
  }
}