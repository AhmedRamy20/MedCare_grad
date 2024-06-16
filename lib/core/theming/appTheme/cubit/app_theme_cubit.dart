import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app/core/theming/appTheme/cubit/app_theme_state.dart';
import 'package:medical_app/core/cache/cache_helper.dart';

// class AppThemeCubit extends Cubit<AppThemeState> {
//   final ChacheHelper _chacheHelper;

//   AppThemeCubit(this._chacheHelper) : super(LightThemeState());

//   void toggleTheme() {
//     if (state is LightThemeState) {
//       emit(DarkThemeState());
//     } else {
//       emit(LightThemeState());
//     }
//   }
// }

//****************************** */

class AppThemeCubit extends Cubit<AppThemeState> {
  final ChacheHelper _cacheHelper;

  AppThemeCubit(this._cacheHelper)
      : super(_cacheHelper.getThemePreference()
            ? DarkThemeState()
            : LightThemeState());

  void toggleTheme() async {
    if (state is LightThemeState) {
      await _cacheHelper.saveThemePreference(true);
      emit(DarkThemeState());
    } else {
      await _cacheHelper.saveThemePreference(false);
      emit(LightThemeState());
    }
  }
}
