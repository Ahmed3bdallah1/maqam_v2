import 'package:flutter/material.dart';
import 'package:maqam_v2/core/constants.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.indigo,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.grey,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    elevation: 20.0,
    backgroundColor: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: Colors.white,
      height: 1.3,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: gray,
);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.indigo,
  primaryColor: Green,
  appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(color: Colors.black)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.indigo,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.black,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
      height: 1.3,
    ),
  ),
  primaryTextTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
      height: 1.3,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: Colors.black),
);
