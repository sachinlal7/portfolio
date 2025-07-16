import 'package:flutter/material.dart';
import 'package:portfolio/app/core/values/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Inter',
      textTheme: _textTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Inter',
      textTheme: _textTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.4,
      ),
    );
  }
}
