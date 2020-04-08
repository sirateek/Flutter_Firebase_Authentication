import 'package:authentication/components/notification.dart';
import 'package:authentication/screens/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final FirebaseUser user;
  const MainPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Authentication"),
        actions: <Widget>[
          IconButton(
            tooltip: "Sign-out",
            icon: Icon(
              Icons.close,
              color: Colors.redAccent,
            ),
            onPressed: () {
              final FirebaseAuth _auth = FirebaseAuth.instance;
              _auth.signOut().then((data) {
                print("Sign-out successfully");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SigninPage()),
                );

                showMessageBox(context,
                    title: "Successfully Sign-out",
                    content: "Please sign in again to access this page");
              }).catchError((e) {
                print(e);
              });
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/Cover.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "Welcome to Firebase Authentication. Happy Developing!",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Text("Your userId is: " + user.uid)
          ],
        ),
      ),
    );
  }
}
