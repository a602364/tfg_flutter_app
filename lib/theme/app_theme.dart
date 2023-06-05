import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color.fromRGBO(44, 68, 160, 1);
  static const Color secondary = Color.fromRGBO(217, 217, 217, 1);

  static final ThemeData light = ThemeData.light().copyWith(
      //color primario
      primaryColor: primary,
      textTheme: GoogleFonts.openSansTextTheme());
}
