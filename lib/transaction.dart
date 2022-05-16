import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Transaction(),
  ));
}

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List list;
  String dropdownValue_d = 'One';
  String dropdownValue_f = null;
  String prev_date = null;
  String holder_f = 'All';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: RichText(
            text: TextSpan(
                text: "Transaction ",
                style: TextStyle(color: Colors.black, fontSize: 30),
                children: [
              TextSpan(
                  text: "History",
                  style: TextStyle(color: Colors.green, fontSize: 30))
            ])),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(children: <Widget>[
        Row(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Date DropDownButton
            DropdownButton<String>(
              onTap: () {
                //Help to refresh the date
                prev_date = null;
              },
              value: dropdownValue_d,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue_d = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            //Filter DropDown Button
            DropdownButton<String>(
              value: dropdownValue_f,
              hint: Text("Filter"),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                prev_date = null;
                setState(() {
                  dropdownValue_f = newValue;
                });
                getDropDownItem();
              },
              items: <String>['All', 'Payment', 'Pickup', 'Redeem']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        ),
        Flexible(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  checkForFilter("October:20", "Payment:TJ0125", "RM 2.71"),
                ],
              ),
            ),
          ),
        ),
      ]),
    ));
  }

  void getDropDownItem() {
    setState(() {
      holder_f = dropdownValue_f;
    });
  }

  Widget createCard(String date, String action, String record) {
    return Card(
      elevation: 0.0,
      child: Column(
        children: <Widget>[
          checkDate(date),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$action',
                  style: TextStyle(
                    fontSize: 18.00,
                  )),
              Text('$record',
                  style: TextStyle(
                    fontSize: 18.00,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget checkForFilter(String _date, String _action, String _record) {
    print(holder_f);
    if (holder_f == null || holder_f == 'All') {
      return createCard(_date, _action, _record);
    } else {
      if (holder_f != null || holder_f != '') {
        if (_action.split(":")[0] == holder_f)
          return createCard(_date, _action, _record);
        else
          return new Container(
            width: 0,
            height: 0,
          );
      }
    }
  }

  Widget checkDate(String _date) {
    //print(prev_date);
    if (prev_date == null || prev_date != _date) {
      prev_date = _date;
      return Text('$_date',
          style: TextStyle(fontSize: 23.00, fontWeight: FontWeight.bold));
    } else
      return new Container(width: 0.0, height: 0.0);
  }
}
