import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData light = ThemeData.from(
    colorScheme: const ColorScheme.light(),
  ).copyWith(bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: Color(0xff6200ee)));
  static ThemeData dark = ThemeData.from(
    colorScheme: const ColorScheme.dark(),
  ).copyWith(bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: Color(0xffbb86fc)));
}
