import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';

class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Inter';

  static const TextStyle _baseTextStyle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.02,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: fontFamily,

      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.lightPrimary,
        onPrimary: AppColors.lightOnPrimary,
        secondary: AppColors.lightSecondary,
        onSecondary: AppColors.lightOnSecondary,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightOnSurface,
        error: AppColors.error,
        onError: AppColors.white,
        outline: AppColors.lightOutline,
        outlineVariant: AppColors.lightOutlineVariant,
        onSurfaceVariant: AppColors.lightOnSurfaceVariant,
      ),

      scaffoldBackgroundColor: AppColors.lightBackground,

      textTheme: TextTheme(
        headlineLarge: _baseTextStyle.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.lightOnBackground,
        ),
        headlineMedium: _baseTextStyle.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.lightOnBackground,
        ),
        headlineSmall: _baseTextStyle.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.lightOnBackground,
        ),

        titleLarge: _baseTextStyle.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.lightOnBackground,
        ),
        titleMedium: _baseTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.lightOnBackground,
        ),
        titleSmall: _baseTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.lightOnBackground,
        ),

        bodyLarge: _baseTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.lightOnBackground,
        ),
        bodyMedium: _baseTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.lightOnBackground,
        ),
        bodySmall: _baseTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.lightOnSurfaceVariant,
        ),

        labelLarge: _baseTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.lightOnBackground,
        ),
        labelMedium: _baseTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.lightOnSurfaceVariant,
        ),
        labelSmall: _baseTextStyle.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppColors.lightOnSurfaceVariant,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: fontFamily,

      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: AppColors.darkPrimary,
        onPrimary: AppColors.darkOnPrimary,
        secondary: AppColors.darkSecondary,
        onSecondary: AppColors.darkOnSecondary,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkOnSurface,
        error: AppColors.error,
        onError: AppColors.white,
        outline: AppColors.darkOutline,
        outlineVariant: AppColors.darkOutlineVariant,
        onSurfaceVariant: AppColors.darkOnSurfaceVariant,
      ),

      scaffoldBackgroundColor: AppColors.darkBackground,

      textTheme: TextTheme(
        headlineLarge: _baseTextStyle.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.darkOnBackground,
        ),
        headlineMedium: _baseTextStyle.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.darkOnBackground,
        ),
        headlineSmall: _baseTextStyle.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnBackground,
        ),

        titleLarge: _baseTextStyle.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnBackground,
        ),
        titleMedium: _baseTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnBackground,
        ),
        titleSmall: _baseTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnBackground,
        ),

        bodyLarge: _baseTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.darkOnBackground,
        ),
        bodyMedium: _baseTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.darkOnBackground,
        ),
        bodySmall: _baseTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.darkOnSurfaceVariant,
        ),

        labelLarge: _baseTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnBackground,
        ),
        labelMedium: _baseTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnSurfaceVariant,
        ),
        labelSmall: _baseTextStyle.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppColors.darkOnSurfaceVariant,
        ),
      ),
    );
  }
}
