import 'package:flutter/material.dart';
import 'responsive_breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= ResponsiveBreakpoints.desktopMin) {
          return desktop;
        }
        if (constraints.maxWidth >= ResponsiveBreakpoints.tabletMin) {
          return tablet ?? desktop;
        }
        return mobile;
      },
    );
  }
}
