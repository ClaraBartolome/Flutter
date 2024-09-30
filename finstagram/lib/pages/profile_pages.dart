import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/firebase_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: _deviceHeight! * 0.02,
          horizontal: _deviceWidth! * 0.05
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _profileImage(),
          _userPosts()
        ],
      ),
    );
  }

  Widget _profileImage(){
    return Container(
      margin: EdgeInsets.only(bottom: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.15,
      width: _deviceHeight! * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(_firebaseService!.getCurrentUser()["image"]),
            fit: BoxFit.cover),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _userPosts(){
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseService!.getUserPost(),
            builder: (BuildContext _context, AsyncSnapshot _snapshot) {
              if(_snapshot.hasData){
                List _posts = _snapshot.data!.docs.map(
                        (e) => e.data()
                ).toList();
                return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 12),
                    itemCount: _posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map _post = _posts[index];
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(_post["image"]),
                                fit: BoxFit.cover)
                        ),
                      );
                    });
              }else{
                return const Center(child: CircularProgressIndicator(
                  color: Colors.pinkAccent,
                ),);
              }
            } ));
  }
}