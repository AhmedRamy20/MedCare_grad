import 'package:flutter/material.dart';
import 'package:medical_app/core/theming/colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: ColorsProvider.primaryBink,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    // Define other light theme properties here
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: ColorsProvider.primaryBink,
    scaffoldBackgroundColor: Colors.grey.shade900,
    brightness: Brightness.dark,
    // Define other dark theme properties here
  );
}
