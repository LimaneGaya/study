import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Pallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _border(Pallete.borderColor),
        focusedBorder: _border(Pallete.gradient2),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Pallete.backgroundColor,
      ));
}

const buttonGradientDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [Pallete.gradient1, Pallete.gradient2, Pallete.gradient3],
  ),
);
const buttonGradientStyle = TextStyle(
    fontSize: 17,
    color: Pallete.backgroundColor,
    fontWeight: FontWeight.w600,
    );
final buttonGradientRadius =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
