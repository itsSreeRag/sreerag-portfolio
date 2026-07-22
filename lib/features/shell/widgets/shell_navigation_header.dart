import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/navigation/scroll_progress_indicator.dart';

/// Top sticky navigation header combining progress bar and custom app bar
class ShellNavigationHeader extends StatelessWidget {
  final double scrollProgress;
  final int activeNavIndex;
  final ValueChanged<String> onItemSelected;
  final VoidCallback onOpenDrawer;

  const ShellNavigationHeader({
    super.key,
    required this.scrollProgress,
    required this.activeNavIndex,
    required this.onItemSelected,
    required this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScrollProgressIndicator(
          progress: scrollProgress,
        ),
        CustomAppBar(
          navItems: AppConstants.navItems,
          activeIndex: activeNavIndex,
          onItemSelected: onItemSelected,
          onOpenDrawer: onOpenDrawer,
        ),
      ],
    );
  }
}
