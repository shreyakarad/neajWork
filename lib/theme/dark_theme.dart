import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColorLight: Color(0xFF202020),
  //primaryColor: Color(0xFF473DA4),
  primaryColor: Color(0xFFFFFFFF),
  primaryColorDark: Color(0xFF473DA4),
  secondaryHeaderColor: Color(0xFF009f67),
  disabledColor: Color(0xffa2a7ad),
  brightness: Brightness.dark,
  hintColor: Color(0xFFbebebe),
  cardColor: Colors.black,
  colorScheme: ColorScheme.dark(
      primary: Color(0xFF473DA4),
      secondary: Color(0xFF7F49F2),
    background: Color(0xFF343636),
    error: Color(0xFFdd3135),
  ),

  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: Color(0xFFcda335))),
);
