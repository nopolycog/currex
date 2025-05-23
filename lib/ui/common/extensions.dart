import 'package:flutter/material.dart';

extension AppContextExt on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
