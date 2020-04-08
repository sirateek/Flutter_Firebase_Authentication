import 'package:authentication/components/notification.dart';
import 'package:authentication/services/signin_with_email_method_services/register_with_email_service.dart';
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
                                return showMessageBox(context,
                                    title: "Failed",
                                    content:
                                        "Please fill in all of the information before start the registation");
                              }
                              if (passwordTextController.text !=
                                  repasswordTextController.text) {
                                return showMessageBox(context,
                                    title: "Failed",
                                    content:
                                        "Your password and re-password doesn't match");
                              }
                              if (await registerWithEmail(
                                email: emailTextController.text,
                                password: passwordTextController.text,
                                repassword: repasswordTextController.text,
                              )) {
                                Navigator.pop(context);
                                showMessageBox(context,
                                    title: "Success",
                                    content:
                                        "Successfully to register your account with this email address.");
                              } else {
                                showMessageBox(context,
                                    title: "Failed",
                                    content:
                                        "An error occurred while registering your account. Please see the output log and try again");
                              }
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
