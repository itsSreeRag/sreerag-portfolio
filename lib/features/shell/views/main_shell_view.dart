import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../widgets/backgrounds/animated_background.dart';
import '../../../widgets/buttons/back_to_top_button.dart';
import '../../../widgets/navigation/app_drawer.dart';
import '../viewmodels/shell_viewmodel.dart';
import '../widgets/shell_navigation_header.dart';
import '../widgets/shell_scroll_content.dart';

class MainShellView extends StatefulWidget {
  final String? initialSection;

  const MainShellView({super.key, this.initialSection});

  @override
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (widget.initialSection != null && widget.initialSection != 'Home') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<ShellViewModel>().scrollToSection(
            widget.initialSection!,
          );
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache hero profile image into GPU memory so it loads instantly without any lag
    precacheImage(const AssetImage('assets/profile/proflie.png'), context);
  }

  @override
  void didUpdateWidget(covariant MainShellView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSection != oldWidget.initialSection &&
        widget.initialSection != null) {
      context.read<ShellViewModel>().scrollToSection(widget.initialSection!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final shellViewModel = context.watch<ShellViewModel>();

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: AppDrawer(
        items: AppConstants.navItems,
        activeIndex: shellViewModel.activeNavIndex,
        onItemSelected: (sectionTitle) {
          shellViewModel.scrollToSection(sectionTitle);
        },
      ),
      body: AnimatedBackground(
        child: Stack(
          children: [
            // Scrollable Content with Centered Container Max Width 1300px
            ShellScrollContent(shellViewModel: shellViewModel),

            // Top Sticky Navigation Bar & Progress Indicator
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ShellNavigationHeader(
                scrollProgress: shellViewModel.scrollProgress,
                activeNavIndex: shellViewModel.activeNavIndex,
                onItemSelected: (title) =>
                    shellViewModel.scrollToSection(title),
                onOpenDrawer: () => _scaffoldKey.currentState?.openEndDrawer(),
              ),
            ),

            // Floating Back To Top Button
            BackToTopButton(
              isVisible: shellViewModel.showBackToTop,
              onPressed: () => shellViewModel.scrollToTop(),
            ),
          ],
        ),
      ),
    );
  }
}
