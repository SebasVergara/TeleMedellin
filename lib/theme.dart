import 'package:flutter/material.dart';

class Style {
  static ThemeData get(bool isDark) {
    Color backgroundColor = isDark ? Color(0xFF434142) : Colors.white;
    Color foregroundColor = isDark ? Colors.white : Colors.black;
    Color invertColor = isDark ? Colors.white : Colors.black;
    Color accentColor = isDark ? Color(0xFF757575) : Color(0xFFf5f5f5);
    Color teleMedellin = Color(0xFFf58025);
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      backgroundColor: backgroundColor,
      canvasColor: backgroundColor,
      textSelectionColor: isDark ? Colors.white12 : Colors.grey.shade300,
      primaryColor: Color(0xFF434142),
      accentColor: accentColor,
      appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
              color: foregroundColor,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: foregroundColor)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: teleMedellin,
      ),
      textTheme: TextTheme(
        display1: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold, fontSize: 25.0),
        display2: TextStyle(color: invertColor, fontSize: 18.0),
        body2: TextStyle(
          color: foregroundColor,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
