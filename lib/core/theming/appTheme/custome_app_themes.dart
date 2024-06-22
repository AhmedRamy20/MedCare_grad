import 'package:flutter/material.dart';
import 'package:medical_app/core/theming/colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: ColorsProvider.primaryBink,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: ColorsProvider.primaryBink,
    scaffoldBackgroundColor: Color.fromARGB(255, 33, 36, 52),
    brightness: Brightness.dark,
  );
}
