import 'package:flutter/material.dart';
import 'package:grabage_user/Wrapper.dart';
import 'package:provider/provider.dart';
import 'package:grabage_user/services/auth.dart';
import 'package:grabage_user/model/user.dart';

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
