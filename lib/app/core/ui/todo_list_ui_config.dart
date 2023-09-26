import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.mandaliTextTheme(),
        primaryColor: const Color(0Xff5C77CE),
        // primaryColorLight: Color(0XFFABC8F7),
        primaryColorLight: Colors.grey[300],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff5c77ce),
          ),
        ),
      );
}
