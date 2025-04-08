import 'package:flutter/material.dart';
import 'package:weather_app/pages/home_with_panel.dart';
import 'package:weather_app/theme/dark_mode.dart';
import 'package:weather_app/theme/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: HomeWithPanel());
  }
}
