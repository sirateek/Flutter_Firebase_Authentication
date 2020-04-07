import 'package:authentication/screens/signin_with_email/register_with_email.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class SigninWithEmail extends StatefulWidget {
  SigninWithEmail({Key key}) : super(key: key);

  @override
  SigninWithEmailState createState() => SigninWithEmailState();
}

class SigninWithEmailState extends State<SigninWithEmail> {
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn(
      {@required String email, @required String password}) async {
    if (email == "" || password == "") {
      print("Null");
      return null;
    }
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result.user);
    } on PlatformException catch (e) {
      return e.code == "ERROR_USER_NOT_FOUND"
          ? print("User not found")
          : print("Unknown error: " + e.details);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign-in With Email/Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.amberAccent,
                          child: Text("Sign-in"),
                          onPressed: () {
                            signIn(
                                email: emailTextController.text,
                                password: passwordTextController.text);
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(5)),
                  Text("Or"),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: FlatButton(
                      child: Text("Register now"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterWithEmail(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
