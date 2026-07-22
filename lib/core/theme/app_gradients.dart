import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppColors.primary, AppColors.accentCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [AppColors.primaryLight, AppColors.accentPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroBackground = LinearGradient(
    colors: [
      Color(0xFF0F172A),
      Color(0xFF0B0F19),
      Color(0xFF090D16),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Color(0x1F2A3B5C),
      Color(0x0A121826),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardBorderGradient = LinearGradient(
    colors: [
      Color(0x6642A5F5),
      Color(0x1A1976D2),
      Color(0x00000000),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
