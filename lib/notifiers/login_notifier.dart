import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  FirebaseUser user;
  loginIn(FirebaseUser user) {
    this.user = user;
  }

  logOut() {
    this.user = null;
  }
}
