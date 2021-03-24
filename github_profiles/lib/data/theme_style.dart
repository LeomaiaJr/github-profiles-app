import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: isDarkTheme ? Colors.white : Colors.black,
        displayColor: isDarkTheme ? Colors.white : Colors.black,
      ),
      primarySwatch: Colors.red,
      primaryColor: isDarkTheme ? Colors.white : Colors.black,
      canvasColor: isDarkTheme ? Color(0xff212121) : Colors.white,
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      primaryIconTheme: IconThemeData(color: Colors.red),
    );
  }
}
