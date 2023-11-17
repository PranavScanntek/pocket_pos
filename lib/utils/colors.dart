import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Color.fromRGBO(255, 61, 143, 1),
  scaffoldBackgroundColor: Color.fromRGBO(248, 248, 248, 1),
  highlightColor: Color.fromRGBO(255, 255, 255, 1),
  shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
  focusColor: Color.fromRGBO(255, 255, 255, 1),
  hintColor: Color.fromRGBO(0, 0, 0, 0.25),
  secondaryHeaderColor: Color.fromRGBO(41, 41, 41, 1),
  indicatorColor: Color.fromRGBO(0, 0, 0, 1),
  
  
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color.fromRGBO(255, 61, 143, 1),
    scaffoldBackgroundColor: Color.fromRGBO(18, 18, 18, 1),
    highlightColor: Color.fromRGBO(255, 255, 255, 1),
    shadowColor: Color.fromRGBO(255, 255, 255, 0.2),
  focusColor: Color.fromRGBO(26, 26, 26, 1),
  hintColor: Color.fromRGBO(255, 255, 255, 0.25),
  secondaryHeaderColor: Color.fromRGBO(248, 248, 248, 1),
  indicatorColor: Color.fromRGBO(255, 255, 255, 1),
);
final lightThemeIcon = Icons.light_mode_outlined; // Replace with your icon
final darkThemeIcon = Icons.dark_mode_outlined;