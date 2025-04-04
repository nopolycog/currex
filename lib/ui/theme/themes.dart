import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData light = ThemeData.from(colorScheme: const ColorScheme.light()).copyWith(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: Color(0xff6200ee)),
    appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: Color(0xff6200ee))),
    dividerTheme: const DividerThemeData(color: Color.fromRGBO(3, 218, 198, 0.2)),
  );
  static ThemeData dark = ThemeData.from(colorScheme: const ColorScheme.dark()).copyWith(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(selectedItemColor: Color(0xffbb86fc)),
    appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: Color(0xffbb86fc))),
    dividerTheme: const DividerThemeData(color: Color.fromRGBO(3, 218, 197, 0.2)),
  );
}
