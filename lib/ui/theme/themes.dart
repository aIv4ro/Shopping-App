import 'package:flutter/material.dart';

abstract class AppTheme {
  const AppTheme();

  ThemeData get data;
  bool get isDarkMode;
}

class DarkTheme extends AppTheme {
  const DarkTheme();

  @override
  ThemeData get data => ThemeData.dark().copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          contentTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      );

  @override
  bool get isDarkMode => true;
}

class LightTheme extends AppTheme {
  const LightTheme();

  @override
  ThemeData get data => ThemeData.light().copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          contentTextStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  @override
  bool get isDarkMode => false;
}
