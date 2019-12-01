import 'package:flutter/material.dart';
import 'package:grouply/colors.dart';

// Widget EmailInput({
//   @required Function callbackSetter,
// }) {
//   return TextFormField(
//     autocorrect: false,
//     decoration: inputDecoration('E-Mail'),
//     keyboardType: TextInputType.emailAddress,
//     maxLines: 1,
//     onSaved: (value) => callbackSetter(
//       value.trim(),
//     ),
//     style: inputTextStyle,
//     validator: (value) =>
//         RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
//                 .hasMatch(value)
//             ? null
//             : 'Bitte gib eine gültige E-Mail ein.',
//   );
// }

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
      decoration: inputDecoration(labelText: labelText),
      keyboardType: keyboardType,
      maxLines: 1,
      obscureText: obscureText,
      onChanged: (String value) => callbackSetter(trimInput ? value.trim() : value),
      style: inputTextStyle,
      validator: validator,
    ),
    margin: EdgeInsets.only(bottom: 16.0),
  );
}
