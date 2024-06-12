// lib/theme/theme.dart
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xff704F38),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
  iconTheme: IconThemeData(color: Colors.black),
  colorScheme: ColorScheme.light(
    primary: Color(0xff704F38),
    onPrimary: Colors.black,
    secondary: Colors.white, 
    onSecondary: Colors.black, 
    error: Colors.red, 
    onError: Colors.white,
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Color(0xff704F38),
  scaffoldBackgroundColor: Color(0xFF222222),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
  iconTheme: IconThemeData(color: Colors.white),
  colorScheme: ColorScheme.dark(
    primary: Color(0xff704F38),
    onPrimary: Colors.white,
    secondary: Colors.grey, 
    onSecondary: Colors.white, 
    error: Colors.red,
    onError: Colors.white,
  ),
);
