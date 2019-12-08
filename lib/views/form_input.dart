import 'package:flutter/material.dart';

import '../colors.dart' as colors;

Widget FormInput({
  bool autovalidate = false,
  @required Function callbackSetter,
  String labelText = '',
  String Function(String) validator,
  bool trimInput = false,
  TextInputType keyboardType,
  bool obscureText = false,
}) {
  return Container(
    height: 56,
    width: 280,
    child: TextFormField(
      autocorrect: false,
      autovalidate: autovalidate,
      decoration: colors.inputDecoration(labelText: labelText),
      keyboardType: keyboardType,
      maxLines: 1,
      obscureText: obscureText,
      onChanged: (String value) =>
          callbackSetter(trimInput ? value.trim() : value),
      style: colors.inputTextStyle,
      validator: validator,
    ),
    margin: EdgeInsets.only(bottom: 16.0),
  );
}
