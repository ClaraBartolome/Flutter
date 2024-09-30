import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finstagram/components/customMaterialButton.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../components/customText.dart';
import '../components/customTextForm.dart';
import '../services/firebase_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }

}

class _RegisterPageState extends State<RegisterPage> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String? _email, _password, _userName;
  Color _profileTextColor = Colors.blueAccent;
  File? _image;

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
      body: SafeArea(child:
          Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _titleWidget(),
                  _imageWidget(),
                  _registrationForms(),
                  _registerButton()
                ],
              ),
            )
          )
      )
    );
  }

  Widget _titleWidget() {
    return customText(
        text: 'Finstagram',
        textColor: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w600);
  }

  Widget _imageWidget(){
    var _imageProvider = _image != null ? FileImage(_image!): const NetworkImage("https://i.pravatar.cc/300");
    return GestureDetector(
      onTap: (){
        FilePicker.platform.pickFiles(type: FileType.image).
        then((_result) => {
          setState(() {
            _image = File(_result!.files.first.path!);
          })
        } );
      },
      child: Column(
        children: [
          Container(
            height: _deviceHeight! * 0.15,
            width: _deviceWidth! * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: _imageProvider as ImageProvider,
                    fit: BoxFit.cover)
            ),
          ),
          customText(
              text: "Pick a profile picture",
              textColor: _profileTextColor,
          fontSize: 15,
          fontWeight: FontWeight.w300)
        ],
      )
    );
  }

  Widget _registrationForms() {
    return SizedBox(
      height: _deviceHeight! * 0.25,
      child: Form(
          key: _registerFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customTextForm(
                  hintText: "Choose a username",
                  labelText: "Username",
                  icon: Icons.person,
                  onSaved: (_value) {
                    setState(() {
                      _userName = _value;
                    });
                  },
                  validator: (_value) {
                    return _value!.isNotEmpty ? null : "Please enter a username";
                    ;
                  }),
              customTextForm(
                  hintText: "Enter you email",
                  labelText: "Email",
                  icon: Icons.email_outlined,
                  onSaved: (_value) {
                    setState(() {
                      _email = _value;
                    });
                  },
                  validator: (_value) {
                    bool _result = _value!.contains(RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"));
                    return _result ? null : "Please enter a valid email";
                    ;
                  }),
              customTextForm(
                hintText: "Enter you passwords",
                labelText: "Password",
                icon: Icons.password_outlined,
                obscureText: true,
                onSaved: (_value) {
                  setState(() {
                    _password = _value;
                  });
                },
                validator: (_value) =>
                _value!.length > 6 ? null : "Please enter a password longer than 6 characters",
              )
            ],
          )),
    );
  }

  Widget _registerButton(){
    return customMaterialButton(
        minWidth: _deviceWidth! * 0.7,
        height: _deviceHeight! * 0.06,
        onPressed: _registerUser,
        color: Colors.pink,
        buttonText: "Register");}

  void _registerUser() async{
    if (_registerFormKey.currentState!.validate() && _image != null) {
      _registerFormKey.currentState!.save();
      bool result = await _firebaseService!.registerUser(
          name: _userName!, email: _email!, password: _password!, image: _image!);
      if(result){
        print("Register successful");
        Navigator.popAndPushNamed(context, "login");
      }
    }else if(_image == null){
      setState(() {
        _profileTextColor = Colors.red;
      });
    }
  }
}