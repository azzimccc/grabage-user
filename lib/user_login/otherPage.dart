import 'package:flutter/material.dart';
import 'package:grabage_user/services/auth.dart';
import 'package:grabage_user/model/newUser.dart';
import 'package:grabage_user/shared/database.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("OTHER PAGE"),
          ),
          body: Container(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (val) =>
                          val.length < 6 ? 'Password must be 7+ letter' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          //print(email);
                          //print(password);
                          //dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          var newU = new NewUser(email, password);
                          DBProvider.db.newUser(newU);
                        }
                      },
                      child: Text('Register'),
                    ),
                    Text(error),
                  ],
                )),
          )),
    );
  }
}
