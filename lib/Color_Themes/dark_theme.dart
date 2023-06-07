import 'package:exptracker/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: opBlack,
  ),
  fontFamily: GoogleFonts.josefinSans().fontFamily,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    
    primary: Colors.grey.shade800,
    primaryContainer: Colors.white,
    secondary: Colors.grey.shade800, //bottom sheet
    secondaryContainer: Colors.grey.shade600,
    inversePrimary: white, //bottom sheet
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
    fillColor: Colors.grey.shade900,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade800,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      // side:  MaterialStatePropertyAll(BorderSide(color: Colors.white)),
      animationDuration: const Duration(microseconds: 1),
      overlayColor: const MaterialStatePropertyAll(
        Colors.black26,
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    ),
  ),
);
