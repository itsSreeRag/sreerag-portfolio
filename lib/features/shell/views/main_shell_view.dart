import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../widgets/backgrounds/animated_background.dart';
import '../../../widgets/buttons/back_to_top_button.dart';
import '../../../widgets/footer/footer.dart';
import '../../../widgets/navigation/app_drawer.dart';
import '../../../widgets/navigation/custom_app_bar.dart';
import '../../../widgets/navigation/scroll_progress_indicator.dart';
import '../../about/views/about_view.dart';
import '../../contact/views/contact_view.dart';
import '../../experience/views/experience_view.dart';
import '../../home/views/home_view.dart';
import '../../home/widgets/technology_strip.dart';
import '../../projects/viewmodels/projects_viewmodel.dart';
import '../../projects/views/projects_view.dart';
import '../../skills/viewmodels/skills_viewmodel.dart';
import '../viewmodels/shell_viewmodel.dart';

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
            RefreshIndicator(
              onRefresh: () async {
                await Future.wait([
                  context.read<SkillsViewModel>().loadSkills(),
                  context.read<ProjectsViewModel>().loadProjects(),
                ]);
              },
              child: SingleChildScrollView(
                controller: shellViewModel.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 70), // AppBar spacing
                    // Centered Container Flow (Hero -> Technology Strip -> About -> Projects -> Experience -> Contact)
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1300),
                        child: Column(
                          children: [
                            Container(
                              key: shellViewModel.sectionKeys['Home'],
                              child: HomeView(
                                onViewProjects: () =>
                                    shellViewModel.scrollToSection('Projects'),
                                onContactMe: () =>
                                    shellViewModel.scrollToSection('Contact'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Technology Strip full width
                    const TechnologyStrip(),

                    // Centered Container for remaining sections
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 1300),
                        child: Column(
                          children: [
                            Container(
                              key: shellViewModel.sectionKeys['About'],
                              child: const AboutView(),
                            ),
                            Container(
                              key: shellViewModel.sectionKeys['Projects'],
                              child: const ProjectsView(),
                            ),
                            Container(
                              key: shellViewModel.sectionKeys['Experience'],
                              child: const ExperienceView(),
                            ),
                            Container(
                              key: shellViewModel.sectionKeys['Contact'],
                              child: const ContactView(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Footer
                    Footer(
                      onNavClick: (title) =>
                          shellViewModel.scrollToSection(title),
                    ),
                  ],
                ),
              ),
            ),

            // Top Sticky Navigation Bar & Progress Indicator
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  ScrollProgressIndicator(
                    progress: shellViewModel.scrollProgress,
                  ),
                  CustomAppBar(
                    navItems: AppConstants.navItems,
                    activeIndex: shellViewModel.activeNavIndex,
                    onItemSelected: (title) =>
                        shellViewModel.scrollToSection(title),
                    onOpenDrawer: () =>
                        _scaffoldKey.currentState?.openEndDrawer(),
                  ),
                ],
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
