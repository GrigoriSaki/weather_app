import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: const Color(0xff4c43e1).withAlpha(200),
      onPrimary: Colors.black,
      surface: Colors.grey.shade800,
      onSurface: Colors.grey.shade400,
      secondary: Colors.grey.shade600,
      onSecondary: Colors.black,
      tertiary: Color(0xff352e94),
      inversePrimary: Colors.black,
    ));
