 import 'package:flutter/material.dart';

ThemeData my_theme() {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
         primary: Colors.blue.shade200,
          onPrimary: Colors.black,
           secondary: Color(0xFFE87C45),
          onSecondary: Colors.deepOrangeAccent.shade100,
          error: Colors.red,
          onError: Colors.red,
          surface: Colors.black,
          onSurface: Colors.black,
        )
    );
  }