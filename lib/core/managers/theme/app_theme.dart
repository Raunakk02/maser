//Define app theme
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final primaryTheme = ThemeData(
    primaryColor: AppColors.sea_blue,
    accentColor: AppColors.lemon,
    focusColor: AppColors.pastel_grey,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: AppColors.sea_blue,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
  );
}
