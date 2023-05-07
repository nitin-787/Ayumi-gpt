import 'package:chatgpt/constants/constants.dart';
import 'package:flutter/material.dart';

class MyTheme {
  final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: scaffoldBackgroundDark,
    canvasColor: darkText,
    focusColor: containerColorDark,
    cardColor: drawerColorDark,
    indicatorColor: iconDark,
    appBarTheme: AppBarTheme(
      color: darkPrimary,
      iconTheme: IconThemeData(
        color: darkText,
      ),
      titleTextStyle: TextStyle(
        color: darkText,
      ),
    ),
  );

  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: scaffoldBackgroundLight,
    canvasColor: lightText,
    focusColor: containerColorLight,
    cardColor: scaffoldBackgroundLight,
    indicatorColor: iconLight,
    appBarTheme: AppBarTheme(
      color: lightPrimary,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
