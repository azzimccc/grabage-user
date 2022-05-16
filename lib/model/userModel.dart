import 'package:flutter/widgets.dart';

class UserModel {
  //final String uid;
  final String username;
  //final String email;
  //final String telephone;
  final String address;

  UserModel({this.username, this.address});
/*
  UserModel(
      {this.uid, this.username, this.email, this.telephone, this.address});
*/
  /*
  factory UserModel.fromJson(Map<dynamic, dynamic> json){
    double parser(dynamic source){
      try{
        return double.parse(source.toString());
      }
      catch(FormatException)
        return -1;
    }

    return UserModel();
  }
  */
  //https://www.youtube.com/watch?v=uoQtH2IYBCU

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(username: json['Name'], address: json['Address']);
  }
}
