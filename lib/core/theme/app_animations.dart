import 'package:flutter/material.dart';

abstract class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration typingSpeed = Duration(milliseconds: 80);

  static const Curve defaultCurve = Curves.easeOutCubic;
  static const Curve springCurve = Curves.elasticOut;
  static const Curve smoothCurve = Curves.easeInOutQuart;
}
