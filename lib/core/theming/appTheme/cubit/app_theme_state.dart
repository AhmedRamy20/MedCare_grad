import 'package:flutter/material.dart';
import 'package:medical_app/core/theming/appTheme/custome_app_themes.dart';

abstract class AppThemeState {
  final ThemeData themeData;
  const AppThemeState(this.themeData);
}

class LightThemeState extends AppThemeState {
  LightThemeState() : super(AppThemes.lightTheme);
}

class DarkThemeState extends AppThemeState {
  DarkThemeState() : super(AppThemes.darkTheme);
}
