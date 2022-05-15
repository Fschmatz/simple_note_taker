import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
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
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFFFFFFFF),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)),
    ),
  ),
  appBarTheme: const AppBarTheme(
      color: Color(0xFFFFFFFF),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF000000)),
      titleTextStyle: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w400, color: Color(0xFF000000))),
  cardTheme: const CardTheme(
    color: Color(0xFFFAFAFA),
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFFFFFFFF),
      focusColor: Colors.teal.shade400,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.teal.shade400,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10.0))),
  chipTheme: ChipThemeData(
    elevation: 0,
    backgroundColor: const Color(0xFFFFFFFF),
    shape: StadiumBorder(
        side: BorderSide(color: Colors.grey.shade800.withOpacity(0.3))),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFFF2F4F6),
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
      backgroundColor: const Color(0xFFD5E6E2),
      indicatorColor: const Color(0xFFA4CFC7),
      iconTheme: MaterialStateProperty.all(const IconThemeData(
        color: Color(0xFF050505),
      )),
      labelTextStyle: MaterialStateProperty.all(const TextStyle(
          color: Color(0xFF050505), fontWeight: FontWeight.w500))),
);

ThemeData dark = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF202122),
  scaffoldBackgroundColor: const Color(0xFF202122),
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF202122),
    primary: Color(0xFF65B29D),
    onPrimary: Color(0xFF003731),
    secondary: Color(0xFF7AD9BE),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF50CCAB),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  ),
  appBarTheme: const AppBarTheme(
      color: Color(0xFF202122),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
      titleTextStyle: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF))),
  cardTheme: const CardTheme(
    color: Color(0xFF2A2D2F),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF202122),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(28)),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFF2A2D2F),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
    ),
  ),
  chipTheme: ChipThemeData(
    elevation: 0,
    backgroundColor: const Color(0xFF202122),
    shape: StadiumBorder(
        side: BorderSide(color: Colors.grey.shade800.withOpacity(0.3))),
  ),
  inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xFF6AB29E),
      focusColor: const Color(0xFF6AB29E),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF6AB29E),
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
          borderRadius: BorderRadius.circular(10.0))),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF2A2D2F),
  ),
  bottomAppBarColor: const Color(0xFF2A2D2F),
  navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF2A2D2F),
      indicatorColor: const Color(0xFF45776F),
      iconTheme: MaterialStateProperty.all(const IconThemeData(
        color: Color(0xFFE0E3E1),
      )),
      labelTextStyle: MaterialStateProperty.all(const TextStyle(
          color: Color(0xFFE0E3E1), fontWeight: FontWeight.w500))),
);
