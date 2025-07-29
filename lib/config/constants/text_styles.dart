import 'package:flutter/material.dart';
import 'package:minimal_todo/config/themes/app_theme.dart';

class AppTextStyles {
  AppTextStyles._();
  static const TextStyle taskTitle = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.02,
  );

  static const TextStyle taskDescription = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
  );

  static const TextStyle taskMeta = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
  );

  static const TextStyle priorityBadge = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  static const TextStyle filterTab = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.01,
  );

  static const TextStyle emptyStateTitle = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.02,
  );

  static const TextStyle emptyStateDescription = TextStyle(
    fontFamily: AppTheme.fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01,
  );
}
