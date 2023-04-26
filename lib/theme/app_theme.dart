import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.indigo;

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      //color primario
      primaryColor: Colors.blueGrey,
      //AppBarTheme
      appBarTheme: const AppBarTheme(elevation: 0, color: Colors.blueGrey),
      scaffoldBackgroundColor: Colors.black);
}
