import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],
    fontFamily: 'NotoKufiArabic', 
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF16226F), 
      foregroundColor: Colors.white, 
      elevation: 0, // Remove shadow
      titleTextStyle: TextStyle(
        fontFamily: 'NotoKufiArabic',
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white), 
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w900),
      displayMedium: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w800),
      displaySmall: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w700),
      headlineLarge: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w400),
      titleLarge: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w300),
      labelLarge: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w400),
      labelSmall: TextStyle(fontFamily: 'NotoKufiArabic', fontWeight: FontWeight.w300),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF16226F), // Border color when focused
          width: 2.0, 
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey, 
        ),
      ),
      hintStyle: TextStyle(color: Colors.grey),
      floatingLabelStyle: TextStyle(color: Color(0xFF16226F)), 
    ),
  );
}
