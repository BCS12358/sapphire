import 'package:flutter/material.dart';

class CustomTheme extends ChangeNotifier {
  bool _isDarkTheme = true;

  ThemeMode currentTheme() {
    if (_isDarkTheme) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  toogleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(color: Colors.black),
    brightness: Brightness.dark,
    iconTheme: const IconThemeData(color: Colors.white),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.blueAccent,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
    ),
  );

  ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(color: Colors.black),
      brightness: Brightness.light,
      // iconTheme: const IconThemeData(color: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.blueAccent,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
      ),
      accentColor: Colors.black);
}
