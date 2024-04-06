import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const String appName = 'QR検証アプリ';
  static const Color themeColor = Colors.green;

  static final ThemeData light = ThemeData.light().copyWith(
    primaryColor: themeColor,
    colorScheme: const ColorScheme.light(
      primary: themeColor,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: themeColor,
    ),
  );
}
