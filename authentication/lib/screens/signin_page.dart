import 'dart:io' show Platform;
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:authentication/components/notification.dart';
import 'package:authentication/components/signin_button.dart';
import 'package:authentication/screens/main_page.dart';
import 'package:authentication/screens/signin_with_email/signin_with_email.dart';
import 'package:authentication/services/signin_with_apple_services/signin_with_apple_services.dart';
import 'package:authentication/services/signin_with_google_services/signin_with_google_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:apple_sign_in/apple_sign_in_button.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/Cover.png",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Text(
                "Welcome to Firebase Authentication",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
              ),
              Text(
                "Please sign-in before you can continue",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    signInButton(
                      context,
                      title: "Sign-in with Email",
                      icon: Icons.email,
                      handler: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SigninWithEmail()),
                        );
                      },
                    ),
                    signInButton(
                      context,
                      title: "Sign-in with Google",
                      icon: FontAwesomeIcons.google,
                      handler: () {
                        signInWithGoogle().then((FirebaseUser user) {
                          print("Successfully sign-in with google");
                          print(user.uid);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(user: user)));
                          showMessageBox(context,
                              title: "Welcome to Firebase Authentication",
                              content: "You've just signed in with Google!");
                        }).catchError((e) {
                          print(e);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: AppleSignInButton(
                        onPressed: () {
                          if (Platform.isIOS) {
                            signInWithApple().then((user) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainPage(user: user)));
                              showMessageBox(context,
                                  title: "Welcome to Firebase Authentication",
                                  content: "You've just signed in with Apple");
                            }).catchError((e) {
                              print(e);
                            });
                          } else {
                            showMessageBox(context,
                                title: "Unsupported Platform",
                                content:
                                    "Sign in with Apple support only on ios platform");
                          }
                        },
                        cornerRadius: 30,
                        style: ButtonStyle.white,
                        type: ButtonType.defaultButton,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
