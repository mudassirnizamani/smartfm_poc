import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
    ),
    colorScheme: const ColorScheme.light(),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.red,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.black,
      primary: Colors.deepOrange,
      onPrimary: Colors.white,
      secondary: const Color(0xff03dac6),
      onSecondary: Colors.black,
      error: const Color(0xffcf6679),
      onError: Colors.black,
      background: const Color(0xff121212),
      onBackground: Colors.white,
      surface: const Color(0xff121212),
      onSurface: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff2c3136),
      unselectedItemColor: Color(0xff535c65),
      selectedItemColor: Color(0xfffb531a),
    ),
  );
}
