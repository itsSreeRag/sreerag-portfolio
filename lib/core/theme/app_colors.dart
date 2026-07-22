import 'package:flutter/material.dart';

/// App color tokens matching the reference image's dark premium aesthetic
abstract class AppColors {
  // Primary Accent Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryGlow = Color(0x4D1976D2);

  // Additional Accent Colors
  static const Color accentCyan = Color(0xFF00E5FF);
  static const Color accentPurple = Color(0xFFB388FF);

  // Red/Coral Highlight Accent for dots & status indicators (as in reference image "Hello .")
  static const Color dotAccent = Color(0xFFFF5252);
  static const Color dotAccentGlow = Color(0x66FF5252);
  static const Color secondary = Color(0xFF00E676);

  // Dark Theme Background & Surfaces
  static const Color background = Color(0xFF0B111A);
  static const Color surface = Color(0xFF111827);
  static const Color surfaceElevated = Color(0xFF151E2B);
  static const Color surfaceBorder = Color(0x14FFFFFF); // rgba(255,255,255,0.08)
  static const Color glassBorder = Color(0x1FFFFFFF);
  static const Color glassSurface = Color(0x1F111827);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB8C1CC);
  static const Color textMuted = Color(0xFF788596);
  static const Color textAccent = Color(0xFF64B5F6);

  // Status & Feedback Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Dividers & Overlay
  static const Color divider = Color(0x1AFFFFFF);
  static const Color overlay = Color(0x99000000);
}
