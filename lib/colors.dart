// Colors and themes will be defined here
import 'package:flutter/material.dart';

// Colordefinitions
const _tealBlue = const Color(0xFF024959);
const _blueLagoon = const Color(0xFF037E8C);
const _blackWhite = const Color(0xFFFFFFFA);
const _pomegranate = const Color(0xFFF24C27);
const _soyaBean = const Color(0xFF5F5448);

// Specify the use and reuse of the variables above
const primaryColor = _tealBlue;
const cardColor = _blackWhite;
const backgroundColor = _blueLagoon;
const warningColor = _pomegranate;

// Declare themes
// TODO: Remove temporary theme any apply above colors
final ThemeData retroTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: backgroundColor,
  cardColor: cardColor,
  primaryColor: primaryColor,
  errorColor: warningColor, 
);
