import 'package:flutter/material.dart';

import '../colors.dart' as colors;

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 280,
            height: 56,
            child: TextFormField(
              style: TextStyle(
                color: colors.cardColor,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: colors.cardColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.cardColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.cardColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 16),
          ),
          Container(
            width: 280,
            height: 56,
            child: TextFormField(
              style: TextStyle(
                color: colors.cardColor,
                fontSize: 16,
              ),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: colors.cardColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.cardColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.cardColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: FlatButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(),
                  ),
                  // TODO: Add functionality to clear input fields
                  onPressed: () {},
                ),
                margin: EdgeInsets.only(
                  right: 16,
                ),
              ),
              Container(
                child: RaisedButton(
                  color: colors.cardColor,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: colors.backgroundColor,
                    ),
                  ),
                  // TODO: Add functionality to check login
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
