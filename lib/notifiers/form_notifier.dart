import 'package:flutter/material.dart';

class FormNotifier extends ChangeNotifier {
  bool isSignUp = false;
  toggleSignUp() {
    isSignUp = !isSignUp;
    notifyListeners();
  }
}
