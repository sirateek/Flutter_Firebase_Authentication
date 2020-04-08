import 'package:flutter/material.dart';
import 'screens/signin_page.dart';

void main() {
  runApp(FIrebaseAuthentication());
}

class FIrebaseAuthentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Authentication Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SigninPage(),
    );
  }
}
