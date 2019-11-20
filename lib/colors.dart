// Colors and themes will be defined here
import 'package:flutter/material.dart';

// Colordefinitions
const tealBlue = const Color(0xFF024959);
const blueLagoon = const Color(0xFF037E8C);
const blackWhite = const Color(0xFFFFFFFA);
const pomegranate = const Color(0xFFF24C27);
const soyaBean = const Color(0xFF5F5448);

// Specify the use and reuse of the variables above
const primaryColor = tealBlue;
const cardColor = blackWhite;
const backgroundColor = blueLagoon;
const warningColor = pomegranate;

// Declare themes
// TODO: Remove temporary theme any apply above colors
final ThemeData retroTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: backgroundColor,
  cardColor: cardColor,
  primaryColor: primaryColor,
  errorColor: warningColor, 
);
