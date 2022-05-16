import 'package:flutter/material.dart';
import 'package:grabage_user/calendarFrame.dart';
import 'package:grabage_user/services/auth.dart';
import 'package:grabage_user/services/databaseServices.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grabage_user/model/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PickupFrame extends StatefulWidget {
  @override
  _PickupFrameState createState() => _PickupFrameState();
}

class _PickupFrameState extends State<PickupFrame> {
  final AuthServices _auth = AuthServices();
  //final FirebaseAuth _mAuth = FirebaseAuth.instance;
  String _uid;
  String _username = '';

  static int row = 6; //6 Type
  static int col = 5; //5 sub type

  var twoDList = List.generate(row, (i) => List<double>(col), growable: false);

  DatabaseReference dbr = DatabaseService().getUserCollection();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUID();
    resetValue();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                !snapshot.hasError &&
                snapshot.data.snapshot.value != null) {
              //print(uid);
              //getUID();
              //print(snapshot.data.snapshot.value);
              //print(DatabaseService().getCurrentUserModel());
              //getUID();
              UserModel _uModel =
                  UserModel.fromJson(snapshot.data.snapshot.value[_uid]);
              print(_uModel.username);
              print(_uModel.address);
              _username = _uModel.username;
            }

            return layoutFold(context);
          },
          stream: dbr.onValue,
        ),
        floatingActionButton: FlatButton(
          child: Text("Logout"),
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ),
    );
  }

  Future navigateToCalendarFrame(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CalendarPage()));
  }

  //HardCoded Value
  String allSubDat =
      "kg|kg|kg|kg|qtty|-qtty|kg|qtty|||-kg|kg||||-qtty|kg|qtty|qtty|qtty|-qtty|qtty|kg|||-kg/qtty|||||-";
  //"kg|kg|kg|kg|qtty|-qtty|kg|qtty|||-kg|kg||||-qtty|qtty|kg|||-qtty|kg|qtty|qtty|qtty|-kg/qtty|||||-";
  String allDat =
      "Sheet|Magazine/Books[Colored]|Magazine/Books|Crumple|Cardboard|-Bottle|Bag|Appliances|||-Tin|Scraps||||-Car Batteries|Batteries|Light Bulb|CPU Waste|Phone|-Bottle|Appliances|Shard|||-Other|||||-";

  double cardWidthSize;
  double cardHeightSize;

  Widget layoutFold(context) {
    cardWidthSize = 150.0;
    cardHeightSize = 170.0;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 2.0),
              child: Text('$_username'),
            ),
            Row(
              children: [
                Container(
                  child: Image.asset(
                    'assets/icon/ico_user_img.png',
                    fit: BoxFit.fill,
                  ),
                  width: 80,
                  height: 80,
                  //padding: new EdgeInsets.only(top: 55.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    border: new Border.all(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 2.0),
                  child: RichText(
                      text: TextSpan(
                          text: "TJ ",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                          children: [
                        TextSpan(
                            text: "0125",
                            style: TextStyle(color: Colors.green, fontSize: 30))
                      ])),
                )
              ],
            ),
            SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                      text: "Choose pickup ",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                      children: [
                    TextSpan(
                        text: "point",
                        style: TextStyle(color: Colors.green, fontSize: 30))
                  ])),
            ),
            RaisedButton.icon(
              onPressed: () {
                //navigateToLoginFrame(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              label: Text("Select available area"),
              textColor: Colors.white,
              color: Colors.green,
              icon: Icon(Icons.location_on),
            ),
            SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                      text: "Choose your ",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                      children: [
                    TextSpan(
                        text: "Date",
                        style: TextStyle(color: Colors.green, fontSize: 30))
                  ])),
            ),
            new RaisedButton.icon(
              onPressed: () {
                navigateToCalendarFrame(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              label: Text("Select Date Available"),
              textColor: Colors.white,
              color: Colors.green,
              icon: Icon(Icons.calendar_today),
            ),
            SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                      text: "Pick your ",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                      children: [
                    TextSpan(
                        text: "item",
                        style: TextStyle(color: Colors.green, fontSize: 30))
                  ])),
            ),
            Table(border: TableBorder.all(color: Colors.white), children: [
              TableRow(children: [
                createImageIcon(context, "Paper/Cardboard",
                    "assets/icon/ico_com_paper_cardboard.png", 0),
                createImageIcon(
                    context, "Plastic", "assets/icon/ico_com_plastic.png", 1),
                createImageIcon(context, "Alloy/Metal",
                    "assets/icon/ico_com_alloy_metal.png", 2),
              ]),
              TableRow(children: [
                createImageIcon(context, "Ewaste/Hazard",
                    "assets/icon/ico_com_ewaste_hazardous.png", 3),
                createImageIcon(
                    context, "Glass", "assets/icon/ico_com_glass.png", 4),
                createImageIcon(
                    context, "Other", "assets/icon/ico_com_others.png", 5),
              ]),
            ]),
            Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 8,
                    decoration: InputDecoration.collapsed(
                        hintText: "Write a note here"),
                  ),
                )),
            FlatButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text("GRABAGE MY ORDER"),
              textColor: Colors.white,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  createDialogBox(BuildContext context, String type, int type_code) {
    //print(allDat.split("-")[type_code]);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            content: SingleChildScrollView(
              child: Card(
                color: Colors.grey,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                      onPressed: () {},
                      label: Text('$type',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      icon: Icon(Icons.pages),
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    makeTextFieldCard(hardGet(allDat, type_code, 0), type_code,
                        0, hardGet(allSubDat, type_code, 0)),
                    makeTextFieldCard(hardGet(allDat, type_code, 1), type_code,
                        1, hardGet(allSubDat, type_code, 1)),
                    makeTextFieldCard(hardGet(allDat, type_code, 2), type_code,
                        2, hardGet(allSubDat, type_code, 2)),
                    makeTextFieldCard(hardGet(allDat, type_code, 3), type_code,
                        3, hardGet(allSubDat, type_code, 3)),
                    makeTextFieldCard(hardGet(allDat, type_code, 4), type_code,
                        4, hardGet(allSubDat, type_code, 4)),
                    /*
                    makeTextFieldCard(
                        allDat.split("-")[type_code].split("|")[4],
                        type_code,
                        4),
                        */
                    FlatButton(
                      color: Colors.grey[100],
                      onPressed: () {
                        totalWaste();
                        Navigator.pop(context);
                      },
                      child: Text("DONE"),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void totalWaste() {
    double total = 0;
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if (twoDList[i][j] == null) {
          print("isNull");
          twoDList[i][j] = 0.0;
        }
        total = total + twoDList[i][j];
      }
    }
    print(total);
  }

  String hardGet(String allString, int major, int minor) {
    //print(allString.split("-")[major].split("|")[minor]);
    //String val = allString.split("-")[major].split("|")[minor];
    //return val.isEmpty ? null : val;
    return allString.split("-")[major].split("|")[minor];
  }

  Widget makeTextFieldCard(
      String _type, int type_code, int subtype_code, String _tail) {
    TextEditingController textFieldController = TextEditingController()
      ..text = setTextFormFieldValue(type_code, subtype_code);
    if (_type == null || _type == '')
      return new Container(
        width: 0,
        height: 0,
      );
    else {
      if (_tail == null || _tail == '') _tail = 'kg';
      return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        color: Colors.white,
        child: ListTile(
          leading: Text('$_type'),
          title: new TextField(
            controller: textFieldController,
            onTap: () {
              textFieldController.text = '';
            },
            onChanged: (value) {
              setState(() {
                twoDList[type_code][subtype_code] = double.parse(value);
                //print(twoDList[type_code][subtype_code]);
              });
            },
            keyboardType: TextInputType.number,
          ),
          trailing: Text('$_tail'),
        ),
      );
    }
  }

  Widget createImageIcon(
      BuildContext context, String name, String path, int type_code) {
    return Container(
      width: cardWidthSize,
      height: cardHeightSize,
      child: IconButton(
        onPressed: () {
          createDialogBox(context, '$name', type_code);
        },
        tooltip: '$name',
        icon: Image.asset(
          '$path',
          fit: BoxFit.fill,
        ),
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  void getUID() async {
    dynamic test = await FirebaseAuth.instance.currentUser();
    _uid = test.uid;
  }

  String setTextFormFieldValue(int type_code, int subtype_code) {
    String val = twoDList[type_code][subtype_code].toString();

    return val.isEmpty ? '' : val;
  }

  void resetValue() {
    for (int i = 0; i < 5; i++)
      for (int j = 0; j < 5; j++) twoDList[i][j] = 0.0;
  }
}
