import 'package:flutter/material.dart';
import 'package:grabage_user/user_login/user_login_screen.dart';
import 'package:grabage_user/user_login/register.dart';
//import 'package:grabage_user/user_login/newLogin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return UserLoginScreen(toggleView: toggleView);
    } else
      return Register(toggleView: toggleView);
  }

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }
}
