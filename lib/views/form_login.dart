import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

import '../activities/home.dart';
import '../colors.dart' as colors;
import '../views/form_input.dart';
import '../views/form_notifier.dart';

class FormLogin extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  String _password;
  String _email;

  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FormNotifier formNotifier = Provider.of<FormNotifier>(context);
    
    return Form(
      key: _formLoginKey,
      child: Column(
        children: <Widget>[
          FormInput(
            callbackSetter: setValue(_email),
            labelText: 'E-Mail',
            keyboardType: TextInputType.emailAddress,
            trimInput: true,
            validator: (input) {
              return RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                          caseSensitive: false)
                      .hasMatch(input)
                  ? null
                  : 'Dieses E-Mail-Format ist ungültig.';
            },
          ),
          FormInput(
            callbackSetter: setValue(_password),
            keyboardType: TextInputType.visiblePassword,
            labelText: 'Passwort',
            obscureText: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: FlatButton(
                  child: Text(
                    'SIGNUP',
                  ),
                  onPressed: () {
                    formNotifier.toggleSignUp();
                  },
                ),
                margin: EdgeInsets.only(
                  right: 16.0,
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
                  onPressed: signIn,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  setValue(String variable) {
    (value) => variable = value;
  }

// credentials validation via firebase_auth
  void signIn() async {
    // TODO: validate user
    final formLoginState = _formLoginKey.currentState;
    // https://pub.dev/packages/firebase_auth
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (formLoginState.validate()) {
      formLoginState.save();
      try {
        FirebaseUser userData = (await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        ))
            .user;
        // * WARNING: `unawaited` might cause a problem
        unawaited(
          // TODO: Either change this so a named route or change the app.dart file. It would probably be better to change this route and outsource it to the app.dart, where all routes are written.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreenTest(
                user: userData,
              ),
            ),
          ),
        );
      } catch (e) {
        print(e.message);
      }
    }
  }
}
