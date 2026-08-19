// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xFF10B981),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      cardColor: const Color(0xFFF9FAFB),
      shadowColor: const Color(0xFF000000),
      dividerColor: const Color(0xFFE5E7EB),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Color(0xFF111827)),
        titleLarge: TextStyle(color: Color(0xFF111827)),
        labelLarge: TextStyle(),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF374151),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF10B981),
      scaffoldBackgroundColor: const Color(0xFF000000),
      cardColor: const Color(0xFF111827),
      shadowColor: const Color(0xFFFFFFFF),
      dividerColor: const Color(0xFF1F2937),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Color(0xFFF9FAFB)),
        titleLarge: TextStyle(color: Color(0xFFF9FAFB)),
        labelLarge: TextStyle(),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF9CA3AF),
      ),
    );
  }
}
