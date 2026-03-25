import 'package:flutter/material.dart';
import 'cubit/theme_cubit.dart';

class AppColors {
  static Color getBackgroundColor(ThemeState theme) {
    return theme is ThemeLight ? _LightColors.background : _DarkColors.background;
  }

  static Color getSurfaceColor(ThemeState theme) {
    return theme is ThemeLight ? _LightColors.surface : _DarkColors.surface;
  }

  static Color getPrimaryColor(ThemeState theme) {
    return theme is ThemeLight ? _LightColors.primary : _DarkColors.primary;
  }

  static Color getTextColor(ThemeState theme) {
    return theme is ThemeLight ? _LightColors.text : _DarkColors.text;
  }

  static Color getTextSecondaryColor(ThemeState theme) {
    return theme is ThemeLight ? _LightColors.textSecondary : _DarkColors.textSecondary;
  }

  static Color getErrorColor(ThemeState theme) {
    return theme is ThemeLight ? _LightColors.error : _DarkColors.error;
  }

  static Color getOutlineColor(ThemeState theme) {
    return theme is ThemeLight ? _LightColors.outline : _DarkColors.outline;
  }

  static Color getPrimaryDarkColor(ThemeState theme) {
    return theme is ThemeLight ? _LightColors.primaryDark : _DarkColors.primaryDark;
  }

  static Color getSuccessColor(ThemeState theme) {
    return theme is ThemeLight ? _LightColors.success : _DarkColors.success;
  }

  static Color getWarningColor(ThemeState theme) {
    return theme is ThemeLight ? _LightColors.warning : _DarkColors.warning;
  }
}

class _LightColors {
  static const Color background = Color(0xFFF8FAFC); // Lighter blue-gray
  static const Color surface = Color(0xFFFFFFFF); // Pure white
  static const Color primary = Color(0xFF6366F1); // Indigo 500
  static const Color primaryDark = Color(0xFF4F46E5); // Indigo 600
  static const Color text = Color(0xFF1E293B); // Slate 800
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color outline = Color(0xFFE2E8F0); // Slate 200
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
}

class _DarkColors {
  static const Color background = Color(0xFF0F172A); // Slate 900
  static const Color surface = Color(0xFF1E293B); // Slate 800
  static const Color primary = Color(0xFF818CF8); // Indigo 400
  static const Color primaryDark = Color(0xFF6366F1); // Indigo 500
  static const Color text = Color(0xFFF1F5F9); // Slate 50
  static const Color textSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color error = Color(0xFFF87171); // Red 400
  static const Color outline = Color(0xFF334155); // Slate 700
  static const Color success = Color(0xFF34D399); // Emerald 400
  static const Color warning = Color(0xFFFBBF24); // Amber 400
}