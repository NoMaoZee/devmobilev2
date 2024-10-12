// File: lib/app/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
  );

  static final dark = ThemeData.dark().copyWith(
    primaryColor: Colors.blue,
  );
}
