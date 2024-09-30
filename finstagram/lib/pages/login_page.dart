import 'package:finstagram/components/customMaterialButton.dart';
import 'package:finstagram/components/customTextForm.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:finstagram/components/customText.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  String? _email, _password;

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
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  _titleWidget(),
                  SizedBox(
                    height: _deviceHeight! * 0.01,
                  ),
                  Image(
                    image:
                        const AssetImage("assets/images/finstagram_logo.png"),
                    width: _deviceWidth! * 0.3,
                  )
                ],
              ),
              _loginForms(),
              _loginButton(),
              _registerPage()
            ],
          ),
        ),
      )),
    );
  }

  Widget _titleWidget() {
    return customText(
        text: 'Finstagram',
        textColor: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w600);
  }

  Widget _loginButton() {
    return customMaterialButton(
        minWidth: _deviceWidth! * 0.7,
        height: _deviceHeight! * 0.06,
        onPressed: _loginForm,
        color: Colors.pink,
        buttonText: "Login");
  }

  Widget _loginForms() {
    return Container(
      height: _deviceHeight! * 0.2,
      child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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

  Widget _registerPage() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "register"),
      child: customText(
          text: "Don't have an account? ",
          textColor: Colors.blueAccent,
          fontSize: 15,
          fontWeight: FontWeight.w300),
    );
  }

  void _loginForm() async {
    //print(_loginFormKey.currentState!.validate());
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      bool result = await _firebaseService!
          .loginUser(email: _email!, password: _password!);
      if(result){
        print("Login successful");
        Navigator.popAndPushNamed(context, "homePage");
      }
    }
  }
}
