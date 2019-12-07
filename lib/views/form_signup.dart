import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

import '../activities/home.dart';
import '../colors.dart' as colors;
import '../notifiers/form_notifier.dart';
import '../notifiers/login_notifier.dart';
import '../views/form_input.dart';

class FormSignUp extends StatefulWidget {
  @override
  _FormSignUpState createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> {
  String _email;
  String _password;
  String _passwordConfirmation;
  // String _username;
  // String _firstName;
  // String _lastName;

  final GlobalKey<FormState> _formSignUpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FormNotifier formNotifier = Provider.of<FormNotifier>(context);

    return Form(
      key: _formSignUpKey,
      child: Column(
        children: <Widget>[
          FormInput(
            callbackSetter: (String value) => _email = value,
            labelText: 'E-Mail',
            keyboardType: TextInputType.emailAddress,
            trimInput: true,
            validator: (input) =>
                RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                            caseSensitive: false)
                        .hasMatch(input)
                    ? null
                    : 'Dieses E-Mail-Format ist ungültig.',
          ),
          FormInput(
            callbackSetter: (String value) => _password = value,
            keyboardType: TextInputType.visiblePassword,
            labelText: 'Passwort',
            obscureText: true,
            validator: (input) =>
                input.length >= 6 ? null : 'Das Passwort ist zu kurz.',
          ),
          FormInput(
            callbackSetter: (String value) => _passwordConfirmation = value,
            keyboardType: TextInputType.visiblePassword,
            labelText: 'Passwort bestätigen',
            obscureText: true,
            validator: (input) => _passwordConfirmation == _password
                ? null
                : 'Die Passwörter stimmen nicht überein.',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: RaisedButton(
                  color: colors.cardColor,
                  onPressed: signUp,
                  child: Text(
                    'BESTÄTIGEN',
                    style: TextStyle(
                      color: colors.backgroundColor,
                    ),
                  ),
                ),
                margin: EdgeInsets.only(
                  right: 16.0,
                ),
              ),
              Container(
                child: FlatButton(
                  child: Text(
                    'LOGIN',
                  ),
                  onPressed: () {
                    formNotifier.toggleSignUp();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void signUp() async {
    final LoginNotifier loginNotifier = Provider.of<LoginNotifier>(context);
    final formSignUpState = _formSignUpKey.currentState;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (formSignUpState.validate()) {
      formSignUpState.save();
      try {
        FirebaseUser result = (await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        ))
            .user;
        unawaited(loginNotifier.loginIn(result));
        unawaited(
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          ),
        );
      } catch (e) {
        print(e.message);
      }
    }
  }
}
