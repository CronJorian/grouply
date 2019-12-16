import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  String _username;
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
            callbackSetter: (String value) => _username = value,
            keyboardType: TextInputType.text,
            labelText: 'Benutzername',
            validator: (input) =>
                input.trim().isEmpty ? 'Der Benutzername ist leer.' : null,
            trimInput: true,
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
    final Firestore _db = Firestore.instance;

    if (formSignUpState.validate()) {
      formSignUpState.save();
      try {
        await _db
            .collection("users")
            .where("username", isEqualTo: _username)
            .getDocuments()
            .then((result) async {
          if (result.documents.isEmpty) {
            FirebaseUser result = (await _auth.createUserWithEmailAndPassword(
              email: _email,
              password: _password,
            ))
                .user;
            await _db
                .collection("users")
                .document(result.uid)
                .setData({"username": _username});
            loginNotifier.loginIn(result);
            await Navigator.of(context).pushNamedAndRemoveUntil(
              '/',
              (Route<dynamic> route) => false,
            );
          }
        }).catchError(
          (error) => {
            // TODO: Catch error for no internet connection, badly formatted email, wrong email, password combination, etc...
          },
        );
      } catch (e) {
        print(e.message);
      }
    }
  }
}
