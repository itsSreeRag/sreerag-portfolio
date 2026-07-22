import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract class AppTypography {
  static TextStyle displayLarge({Color color = AppColors.textPrimary}) =>
      GoogleFonts.outfit(
        fontSize: 54,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.0,
        height: 1.1,
        color: color,
      );

  static TextStyle displayMedium({Color color = AppColors.textPrimary}) =>
      GoogleFonts.outfit(
        fontSize: 38,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.2,
        color: color,
      );

  static TextStyle titleLarge({Color color = AppColors.textPrimary}) =>
      GoogleFonts.outfit(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        color: color,
      );

  static TextStyle titleMedium({Color color = AppColors.textPrimary}) =>
      GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle bodyLarge({Color color = AppColors.textSecondary}) =>
      GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.65,
        color: color,
      );

  static TextStyle bodyMedium({Color color = AppColors.textSecondary}) =>
      GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.55,
        color: color,
      );

  static TextStyle labelLarge({Color color = AppColors.textPrimary}) =>
      GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
        color: color,
      );

  static TextStyle caption({Color color = AppColors.textMuted}) =>
      GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
      );
}
