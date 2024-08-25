import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Satoshi',
      colorScheme: const ColorScheme.light(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'Satoshi',
      colorScheme: const ColorScheme.dark(),
    );
  }
}
