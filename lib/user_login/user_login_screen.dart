import 'package:flutter/material.dart';
import 'package:grabage_user/services/auth.dart';
import 'package:grabage_user/shared/loading.dart';

class UserLoginScreen extends StatefulWidget {
  //This become parameter like child: yada2
  final Color primaryColor;
  final Color backgroundColor;
  final Function toggleView;

  UserLoginScreen(
      {Key key, this.primaryColor, this.backgroundColor, this.toggleView});

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  bool loading = false;

  //Empty State
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : new Material(
            child: SingleChildScrollView(
              child: Container(
                //height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: this.widget.backgroundColor,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 130.0, bottom: 100.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "DEMO",
                                style: TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold,
                                    color: this.widget.primaryColor),
                              ),
                              Text(
                                "Login Screen 1",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: this.widget.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "Username",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin: const EdgeInsets.only(
                                  left: 00.0, right: 10.0),
                            ),
                            new Expanded(
                              child: TextFormField(
                                validator: (val) =>
                                    val.isEmpty ? 'Enter email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your Email',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "Password",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.lock_open,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin: const EdgeInsets.only(
                                  left: 00.0, right: 10.0),
                            ),
                            new Expanded(
                              child: TextFormField(
                                validator: (val) => val.length < 6
                                    ? 'Password must be 7+ letter'
                                    : null,
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                splashColor: this.widget.primaryColor,
                                color: this.widget.primaryColor,
                                child: new Row(
                                  children: <Widget>[
                                    new Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    new Expanded(
                                      child: Container(),
                                    ),
                                    new Transform.translate(
                                      offset: Offset(15.0, 0.0),
                                      child: new Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: FlatButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      28.0)),
                                          splashColor: Colors.white,
                                          color: Colors.white,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: this.widget.primaryColor,
                                          ),
                                          onPressed: () async {
                                            //dynamic because could be user or null
                                            //print(email);
                                            //print(password);
                                            if (_formKey.currentState
                                                .validate()) {
                                              setState(() => loading = true);
                                              dynamic result = await _auth
                                                  .signInWithEmailAndPassword(
                                                      email, password);
                                              if (result == null) {
                                                setState(() {
                                                  error = 'Error signing in';
                                                  loading = false;
                                                });
                                              }
                                            }

                                            /*
                                      dynamic result = await _auth.signInAnon();

                                      if (result == null)
                                        print("Error signin in");
                                      else {
                                        print("Sign in :");
                                        print(result.uid);
                                      }
                                      */
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                onPressed: () => {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                                child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Colors.transparent,
                              child: Container(
                                padding: const EdgeInsets.only(left: 20.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "DON'T HAVE AN ACCOUNT?",
                                  style: TextStyle(
                                      color: this.widget.primaryColor),
                                ),
                              ),
                              onPressed: () {
                                widget.toggleView();
                              },
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }

  gotoSignup() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);
}
