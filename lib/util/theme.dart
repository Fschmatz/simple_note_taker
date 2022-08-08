import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(fontWeight: FontWeight.w400),
  ),
  brightness: Brightness.light,
  primaryColor: const Color(0xFFFAFDFA),
  scaffoldBackgroundColor: const Color(0xFFFAFDFA),
  colorScheme: const ColorScheme.light(
    background: Color(0xFFFFFFFF),
    primary: Color(0xFF02836A),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Colors.teal,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF02836A),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFFFAFDFA),
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Color(0xFFFAFDFA),
    color: Color(0xFFFAFDFA),
  ),
  cardTheme: const CardTheme(
    color: Color(0xFFFAFDFA),
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFFFAFDFA),
      focusColor: const Color(0xFF02836A),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF02836A),
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
    backgroundColor: Color(0xFFFAFDFA),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFD5E6E2),
    selectedItemColor: Color(0xFF02836A),
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
  primaryColor: const Color(0xFF1B1B1D),
  scaffoldBackgroundColor: const Color(0xFF1B1B1D),
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF1B1B1D),
    primary: Color(0xFF5DDBBD),
    onPrimary: Color(0xFF00382C),
    secondary: Color(0xFF5DDBBD),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF5DDBBD),
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Color(0xFF1B1B1D),
    color: Color(0xFF1B1B1D),
  ),
  cardTheme: const CardTheme(
    color: Color(0xFF242628),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF1B1B1D),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFF1B1B1D),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(      
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
    backgroundColor: Color(0xFF292A2D),
  ),
  bottomAppBarColor: const Color(0xFF292A2D),
  navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF292A2D), //0xFF1B1B1D
      indicatorColor: const Color(0xFF3C6062),
      iconTheme: MaterialStateProperty.all(const IconThemeData(
        color: Color(0xFFE0E3E1),
      )),
      labelTextStyle: MaterialStateProperty.all(const TextStyle(
          color: Color(0xFFE0E3E1), fontWeight: FontWeight.w500))),
);
