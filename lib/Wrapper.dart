import 'package:flutter/material.dart';
import 'package:grabage_user/Authenticate.dart';
import 'package:grabage_user/PickupFrame.dart';
import 'package:grabage_user/model/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //print(user);

    if (user == null)
      return Authenticate();
    else {
      return PickupFrame();
    }
  }
}
