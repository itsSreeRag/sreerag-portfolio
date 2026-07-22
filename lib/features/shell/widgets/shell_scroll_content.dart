import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/footer/footer.dart';
import '../../about/views/about_view.dart';
import '../../contact/views/contact_view.dart';
import '../../experience/views/experience_view.dart';
import '../../home/views/home_view.dart';
import '../../home/widgets/technology_strip.dart';
import '../../projects/viewmodels/projects_viewmodel.dart';
import '../../projects/views/projects_view.dart';
import '../../skills/viewmodels/skills_viewmodel.dart';
import '../viewmodels/shell_viewmodel.dart';

/// Main scrollable content view containing all portfolio sections
class ShellScrollContent extends StatelessWidget {
  final ShellViewModel shellViewModel;

  const ShellScrollContent({
    super.key,
    required this.shellViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
    );
  }
}
