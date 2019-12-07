import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors.dart' as colors;
import '../views/form_login.dart';
import '../notifiers/form_notifier.dart';
import '../views/form_signup.dart';

// TODO: make login view stateful to save userID in the process
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final FormNotifier formNotifier = Provider.of<FormNotifier>(context);

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
                // TODO: Instead of two widgets, use one with a lost, or something like that, so that it won't "reload",
                // ! but instead let a third input form (for password confirmation) appear and change the buttons and their
                // ! respective functionality
                formNotifier.isSignUp ? FormSignUp() : FormLogin()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
