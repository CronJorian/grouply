// Colors and themes will be defined here
import 'package:flutter/material.dart';

// Colordefinitions
const _tealBlue = Color(0xFF024959);
const _blueLagoon = Color(0xFF037E8C);
const _blackWhite = Color(0xFFFFFFFA);
const _pomegranate = Color(0xFFF24C27);
// const _soyaBean = Color(0xFF5F5448);

// Specify the use and reuse of the variables above
const primaryColor = _tealBlue;
const cardColor = _blackWhite;
const backgroundColor = _blueLagoon;
const warningColor = _pomegranate;

// Declare themes
final ThemeData retroTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: backgroundColor,
  cardColor: cardColor,
  primaryColor: primaryColor,
  errorColor: warningColor,
);

final TextStyle inputTextStyle = TextStyle(
  color: cardColor,
  fontSize: 16,
);

InputDecoration inputDecoration({String labelText = ""}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(
      color: cardColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: cardColor,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: cardColor,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: warningColor,
        width: 1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: warningColor,
        width: 2,
      ),
    ),
  );
}
