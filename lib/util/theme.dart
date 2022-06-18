import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontWeight: FontWeight.w400),
  ),
  brightness: Brightness.light,
  primaryColor: const Color(0xFFFFFFFF),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  colorScheme: ColorScheme.light(
    background: const Color(0xFFFFFFFF),
    primary: Colors.teal.shade400,
    onPrimary: const Color(0xFFFFFFFF),
    secondary: Colors.teal,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.teal.shade400,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFFFFFFFF),
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Color(0xFFFFFFFF),
    color: Color(0xFFFFFFFF),
  ),
  cardTheme: const CardTheme(
    color: Color(0xFFFFFFFF),
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFFFFFFFF),
      focusColor: Colors.teal.shade400,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.teal.shade400,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8.0)),
      border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8.0))),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFFF4F6F8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: const Color(0xFFD5E6E2),
    selectedItemColor: Colors.teal.shade400,
  ),
  bottomAppBarColor: const Color(0xFFD5E6E2),
  navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFFD5E6E2), //0xFFD5E6E2
      indicatorColor: const Color(0xFFA4CFC7), //0xFFA4CFC7
      iconTheme: MaterialStateProperty.all(const IconThemeData(
        color: Color(0xFF050505),
      )),
      labelTextStyle: MaterialStateProperty.all(const TextStyle(
          color: Color(0xFF050505), fontWeight: FontWeight.w500))),
);

ThemeData dark = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontWeight: FontWeight.w400),
  ),
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF202122),
  scaffoldBackgroundColor: const Color(0xFF202122),
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF202122),
    primary: Color(0xFF65B29D),
    onPrimary: Color(0xFF003722),
    secondary: Color(0xFF7AD9BE),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF21A482),
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Color(0xFF202122),
    color: Color(0xFF202122),
  ),
  cardTheme: const CardTheme(
    color: Color(0xFF242628),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF202122),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFF202122),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFF6AB29E),
      focusColor: const Color(0xFF6AB29E),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF6AB29E),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
          borderRadius: BorderRadius.circular(8.0)),
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
          borderRadius: BorderRadius.circular(8.0))),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF2A2D2F),
  ),
  bottomAppBarColor: const Color(0xFF2A2D2F),
  navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF2A2D2F), //0xFF202122
      indicatorColor: const Color(0xFF367A6F),
      iconTheme: MaterialStateProperty.all(const IconThemeData(
        color: Color(0xFFE0E3E1),
      )),
      labelTextStyle: MaterialStateProperty.all(const TextStyle(
          color: Color(0xFFE0E3E1), fontWeight: FontWeight.w500))),
);
