import 'package:chatgpt/constants/constants.dart';
import 'package:flutter/material.dart';

class MyTheme {
  final darkTheme = ThemeData(
    scaffoldBackgroundColor: scaffoldBackgroundDark,
    // text color
    canvasColor: darkText,
    // text container color
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

  final lightTheme = ThemeData(
    // text color & icon color
    canvasColor: lightText,
    // text container color
    focusColor: containerColorLight,
    cardColor: drawerColorDark,
    indicatorColor: iconLight,
    scaffoldBackgroundColor: scaffoldBackgroundLight,
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
