import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      scrolledUnderElevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(30),
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.onPrimary,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        disabledBackgroundColor: AppColors.disable,
        disabledForegroundColor: AppColors.onDisable,
        side: const BorderSide(width: 2, color: AppColors.primary),
        textStyle: AppTypography.s12,
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(30),
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.white,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        disabledBackgroundColor: AppColors.disable,
        disabledForegroundColor: AppColors.onDisable,
        side: const BorderSide(width: 2, color: AppColors.primary),
        textStyle: AppTypography.s14.withColor(AppColors.primary),
        elevation: 0,
      ),
    ),
  );
}
