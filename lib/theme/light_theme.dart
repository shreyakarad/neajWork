import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Roboto',
  //primaryColor: Color(0xFF473DA4),
  primaryColor: Color(0xFF2761E7),
  // primaryColor: Color(0xFF6656FB),
  //primaryColorDark: Color(0xFF223263),
  primaryColorDark: Color(0xFF2761E7),
  secondaryHeaderColor: Color(0xFF1ED7AA),
  primaryColorLight: Color(0xFFC0BAFB),
  disabledColor: Color(0xFFBABFC4),
  brightness: Brightness.light,
  hintColor: Color(0xFF9098B1),
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(
    onBackground: Color(0xFFF5F5F5),
    primary: Color(0xFF6656FB),
    secondary: Color(0xFF473DA4),
    background: Color(0xFFF5F5F5),
    error: Color(0xFFE84D4F),
    primaryContainer: Color(0xFF7F49F2),
    secondaryContainer: Color(0xFF1700ED),
    surface: Color(0xFFF0EEFF),
    surfaceTint: Color(0xFFECEAFF),
    surfaceVariant: Color(0xFFFFFFFF),
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Color(0xFF473DA4))),
  textTheme: TextTheme(
      displayMedium:
          TextStyle(fontWeight: FontWeight.w300, color: Color(0xFF4F5663)),
      labelSmall: TextStyle(color: Color(0xFF9098B1))),
);
