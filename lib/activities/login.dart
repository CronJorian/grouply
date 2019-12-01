import 'package:flutter/material.dart';
import 'package:grouply/views/form_signup.dart';

import '../colors.dart' as colors;
import '../views/form_login.dart';

// TODO: make login view stateful to save userID in the process
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Grouply',
                    style: TextStyle(
                      fontSize: 72,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.w500,
                      color: colors.cardColor,
                    ),
                  ),
                  margin: EdgeInsets.only(
                    bottom: 40,
                  ),
                ),
                FormSignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
