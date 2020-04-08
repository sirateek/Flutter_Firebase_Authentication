import 'package:flutter/material.dart';

Widget signInButton(BuildContext context,
    {@required String title,
    @required IconData icon,
    @required Function handler}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
    child: Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(title),
                  Padding(
                    padding: const EdgeInsets.all(5),
                  ),
                  Icon(icon)
                ],
              ),
              onPressed: handler),
        )
      ],
    ),
  );
}
