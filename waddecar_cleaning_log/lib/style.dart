import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
  ),

  textTheme: TextTheme(
    // Body styles
    bodySmall: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.6,
    ),

    // Title styles
    titleSmall: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.4,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.5,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 1.6,
    ),

    // Label styles
    labelSmall: GoogleFonts.lato(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.3,
    ),
  )
  
);