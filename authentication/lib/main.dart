import 'package:authentication/screens/signin_with_email/signin_with_email.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FIrebaseAuthentication());
}

class FIrebaseAuthentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SigninWithEmail(),
    );
  }
}
