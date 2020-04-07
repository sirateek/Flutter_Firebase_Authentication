import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterWithEmail extends StatefulWidget {
  RegisterWithEmail({Key key}) : super(key: key);

  @override
  RegisterWithEmailState createState() => RegisterWithEmailState();
}

class RegisterWithEmailState extends State<RegisterWithEmail> {
  @override
  Widget build(BuildContext context) {
    var emailTextController = TextEditingController();
    var passwordTextController = TextEditingController();
    var repasswordTextController = TextEditingController();

    Future<bool> register(
        {@required email, @required password, @required repassword}) {
      FirebaseAuth _auth = FirebaseAuth.instance;
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

    return Scaffold(
        appBar: AppBar(
          title: Text("Register your account"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              "Please Sign-in with your Email/Password",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: emailTextController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "example@sirateek.dev",
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(8)),
                    TextFormField(
                        controller: passwordTextController,
                        decoration: InputDecoration(labelText: "Password"),
                        obscureText: true),
                    Padding(padding: const EdgeInsets.all(8)),
                    TextFormField(
                        controller: repasswordTextController,
                        decoration: InputDecoration(labelText: "Re-Password"),
                        obscureText: true),
                    Padding(padding: const EdgeInsets.all(8)),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Colors.lightBlueAccent,
                            child: Text("Register"),
                            onPressed: () async {
                              if (emailTextController.text == "" ||
                                  passwordTextController.text == "" ||
                                  repasswordTextController.text == "") {
                                return null;
                              }
                              if (passwordTextController.text !=
                                  repasswordTextController.text) {
                                return null;
                              }
                              return await register(
                                email: emailTextController.text,
                                password: passwordTextController.text,
                                repassword: repasswordTextController.text,
                              )
                                  ? print("")
                                  : print("");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
