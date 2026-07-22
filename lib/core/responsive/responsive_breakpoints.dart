import 'package:flutter/material.dart';

abstract class ResponsiveBreakpoints {
  static const double mobileMax = 649.0;
  static const double tabletMin = 650.0;
  static const double tabletMax = 899.0;
  static const double laptopMin = 900.0;
  static const double laptopMax = 1099.0;
  static const double desktopMin = 1100.0;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= mobileMax;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tabletMin && width <= tabletMax;
  }

  static bool isLaptop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= laptopMin && width <= laptopMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopMin;
}
