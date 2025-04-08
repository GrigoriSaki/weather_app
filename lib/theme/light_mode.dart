import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: const Color(0xff4c43e1),
      onPrimary: Colors.white,
      surface: Colors.grey.shade200,
      onSurface: Colors.black,
      secondary: Colors.grey.shade400,
      onSecondary: Colors.black,
      tertiary: Color(0xff6d66f0),
      inversePrimary: Colors.white,
    ));
