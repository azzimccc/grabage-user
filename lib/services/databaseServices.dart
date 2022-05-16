import 'package:firebase_database/firebase_database.dart';
import 'package:grabage_user/model/newUser.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  //Collection Reference
  final userCollection = FirebaseDatabase.instance.reference();

  DatabaseReference getUserCollection() {
    return userCollection;
  }

  //Update
  Future updateUserData(String name, String address) async {
    return await userCollection.child(uid).update({
      'Name': name,
      'Address': address,
    });
  }

  //Create
  Future createUserData(String name, String address) async {
    return await userCollection.child(uid).set({
      'Name': name,
      'Address': address,
    });
  }

  //Get Stream

  //Delete
}
