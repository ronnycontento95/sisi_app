import 'package:flutter/services.dart';

List<TextInputFormatter> formattersUser() {
  return [
    FilteringTextInputFormatter.deny(RegExp(r'ñ'), replacementString: ''),
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z-0-9 ]")),
    LengthLimitingTextInputFormatter(30),
  ];
}

List<TextInputFormatter> formattersPassword() {
  return [
    FilteringTextInputFormatter.allow(RegExp('[0-9A-Za-z.,]'),),
    LengthLimitingTextInputFormatter(30),
  ];
}