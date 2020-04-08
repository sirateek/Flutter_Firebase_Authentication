import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> registerWithEmail(
    {@required email, @required password, @required repassword}) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  return _auth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((data) {
    print("Registation Success");
    print(data.user.uid);
    return true;
  }).catchError((e) {
    print("Error: " + e);
    return false;
  });
}
