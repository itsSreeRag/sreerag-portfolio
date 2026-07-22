import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppShadows {
  static const BoxShadow soft = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 16.0,
    offset: Offset(0, 8),
  );

  static const BoxShadow glow = BoxShadow(
    color: AppColors.primaryGlow,
    blurRadius: 24.0,
    spreadRadius: 2.0,
    offset: Offset(0, 4),
  );

  static const BoxShadow glass = BoxShadow(
    color: Color(0x1F000000),
    blurRadius: 20.0,
    offset: Offset(0, 10),
  );
}
