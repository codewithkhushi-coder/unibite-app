import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Main Brand Colors
  static const Color primary = Color(0xFF673AB7); // Premium Deep Purple
  static const Color primaryLight = Color(0xFF9575CD); // Soft Purple
  static const Color primaryDark = Color(0xFF512DA8); // Dark Purple

  // Background & Surfaces
  static const Color scaffoldBackground = Color(0xFFFFFFFF); // Pure White
  static const Color displaySurface = Color(0xFFF9F9FB); // Off-White for cards
  static const Color cardShadow = Color(0x0A000000); // 4% opacity black

  // Typography
  static const Color textPrimary = Color(0xFF1E1E24); // Almost Black
  static const Color textSecondary = Color(0xFF757575); // Neutral Grey
  static const Color textHint = Color(0xFFBDBDBD);

  // Status Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
}
