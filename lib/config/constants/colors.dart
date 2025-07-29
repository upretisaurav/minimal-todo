import 'package:flutter/material.dart';

class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Light and Dark Theme Colors
  static const Color lightPrimary = black;
  static const Color lightSecondary = gray600;
  static const Color lightBackground = white;
  static const Color lightSurface = white;
  static const Color lightSurfaceVariant = gray50;
  static const Color lightOnPrimary = white;
  static const Color lightOnSecondary = white;
  static const Color lightOnBackground = black;
  static const Color lightOnSurface = black;
  static const Color lightOnSurfaceVariant = gray600;
  static const Color lightOutline = gray200;
  static const Color lightOutlineVariant = gray100;

  static const Color darkPrimary = white;
  static const Color darkSecondary = gray400;
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF111111);
  static const Color darkSurfaceVariant = Color(0xFF1A1A1A);
  static const Color darkOnPrimary = black;
  static const Color darkOnSecondary = black;
  static const Color darkOnBackground = white;
  static const Color darkOnSurface = white;
  static const Color darkOnSurfaceVariant = gray400;
  static const Color darkOutline = Color(0xFF2D2D2D);
  static const Color darkOutlineVariant = Color(0xFF1F1F1F);

  // Priority Colors
  static const Color priorityHigh = error;
  static const Color priorityMedium = warning;
  static const Color priorityLow = success;

  static const Color priorityHighBgLight = Color(0xFFFEF2F2);
  static const Color priorityMediumBgLight = Color(0xFFFFFBEB);
  static const Color priorityLowBgLight = Color(0xFFF0FDF4);

  static const Color priorityHighBgDark = Color(0xFF1F1717);
  static const Color priorityMediumBgDark = Color(0xFF1F1B17);
  static const Color priorityLowBgDark = Color(0xFF171F17);
}

extension AppColorsExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  Color get primaryColor => colors.primary;
  Color get surfaceColor => colors.surface;
  Color get onSurfaceColor => colors.onSurface;

  Color get taskCardBg =>
      Theme.of(this).brightness == Brightness.light
          ? AppColors.white
          : AppColors.darkSurface;

  Color get taskCardBorder =>
      Theme.of(this).brightness == Brightness.light
          ? AppColors.gray200
          : AppColors.darkOutline;

  Color get priorityHighColor => AppColors.priorityHigh;
  Color get priorityMediumColor => AppColors.priorityMedium;
  Color get priorityLowColor => AppColors.priorityLow;

  Color priorityBgColor(String priority) {
    final isLight = Theme.of(this).brightness == Brightness.light;
    switch (priority.toLowerCase()) {
      case 'high':
        return isLight
            ? AppColors.priorityHighBgLight
            : AppColors.priorityHighBgDark;
      case 'medium':
        return isLight
            ? AppColors.priorityMediumBgLight
            : AppColors.priorityMediumBgDark;
      case 'low':
        return isLight
            ? AppColors.priorityLowBgLight
            : AppColors.priorityLowBgDark;
      default:
        return isLight ? AppColors.gray100 : AppColors.darkSurfaceVariant;
    }
  }
}
