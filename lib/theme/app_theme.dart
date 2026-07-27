import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: Colors.deepOrange,
    scaffoldBackgroundColor: const Color(0xFFFFFBF7),
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    cardTheme: const CardThemeData(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorSchemeSeed: Colors.deepOrange,
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    cardTheme: const CardThemeData(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
  );
}
