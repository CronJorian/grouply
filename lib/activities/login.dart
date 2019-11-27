import 'package:flutter/material.dart';

import '../colors.dart' as colors;
import '../views/login_form.dart';

// TODO: make login view stateful to save userID in the process
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryColor,
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Grouply',
              style: TextStyle(
                fontSize: 72,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.w500,
                color: colors.cardColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 40,
              ),
              child: LoginForm(),
            ),
          ],
        ),
      ),
    );
  }
}
