import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/components/customText.dart';
import 'package:finstagram/pages/feed_page.dart';
import 'package:finstagram/pages/profile_pages.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/firebase_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;

  int _currentPage = 0;
  final List<Widget> _fakePages = [
    FeedPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavBar(),
      body: _fakePages[_currentPage],
    );
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(label: "Feed", icon: Icon(Icons.feed)),
          BottomNavigationBarItem(
              label: "Profile", icon: Icon(Icons.account_box_rounded)),
        ]);
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: customText(text: "Finstagram"),
      backgroundColor: Colors.pinkAccent,
      actions: [
        GestureDetector(
          onTap: _postImage,
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: GestureDetector(
            onTap: _logout,
            child: const Icon(Icons.logout, color: Colors.white),
          ),
        )
      ],
    );
  }

  void _postImage() async{
    FilePickerResult? _result = await FilePicker.platform.pickFiles(type: FileType.image);
    File _image = File(_result!.files.first.path!);
    await _firebaseService!.postImage(image: _image);
  }

  void _logout() async{
    await _firebaseService!.logout();
    Navigator.popAndPushNamed(context, "login");
  }
}
