import 'package:flutter/material.dart';

import '../colors.dart' as colors;

// TODO: extract the login functionality into a component
// TODO: make login view stateful to save userID in the process
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.primaryColor,
        body: Center(
          child: Container(
            width: 280,
            height: 320,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Text(
                    'Grouply',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 72,
                      color: colors.cardColor,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                          ),
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
