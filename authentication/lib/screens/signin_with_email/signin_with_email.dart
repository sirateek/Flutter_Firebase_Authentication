import 'package:authentication/components/notification.dart';
import 'package:authentication/screens/signin_with_email/register_with_email.dart';
import 'package:authentication/services/signin_with_email_method_services/signin_with_email_service.dart';
import 'package:flutter/material.dart';

class SigninWithEmail extends StatefulWidget {
  SigninWithEmail({Key key}) : super(key: key);

  @override
  SigninWithEmailState createState() => SigninWithEmailState();
}

class SigninWithEmailState extends State<SigninWithEmail> {
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();

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
                          onPressed: () async {
                            if (emailTextController.text == "" ||
                                passwordTextController.text == "") {
                              return showMessageBox(context,
                                  title: "Failed",
                                  content:
                                      "Please fill in all of the information");
                            }

                            if (await signInWithEmail(context,
                                email: emailTextController.text,
                                password: passwordTextController.text)) {
                              print("Signin Success");
                              showMessageBox(context,
                                  title: "Successfully to sign you in",
                                  content:
                                      "Welcome to Firebase, Happy Developing!");
                            } else {
                              return showMessageBox(context,
                                  title: "Failed",
                                  content:
                                      "We can't sign you in with these credential. Please see the output log and try again.");
                            }
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
