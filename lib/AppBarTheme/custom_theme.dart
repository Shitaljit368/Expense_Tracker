import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constant/colors.dart';

ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.white,
    primaryContainer: Colors.black,
    secondary: Colors.grey.shade300, //bottom sheet
    secondaryContainer: Colors.grey.shade200,
    inversePrimary: white,//botton sheet cancel button
    onSecondary: Colors.black12
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: opBlack,
  ),
  fontFamily: GoogleFonts.josefinSans().fontFamily,
  inputDecorationTheme: InputDecorationTheme(
    
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide:  BorderSide(
        color: Colors.grey.shade400,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade700,
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
