import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../widgets/loaders/project_shimmer.dart';
import '../../../widgets/typography/section_header.dart';
import '../viewmodels/projects_viewmodel.dart';
import '../widgets/project_card.dart';
import '../widgets/project_detail_dialog.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.md : AppSpacing.xl,
        vertical: AppSpacing.xxl,
      ),
      child: Consumer<ProjectsViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Projects',
                subtitle: 'Production software engineered with clean architecture, state management, and robust logic.',
              ),
              const SizedBox(height: AppSpacing.xxl),

              if (viewModel.isLoading)
                Column(
                  children: List.generate(
                    3,
                    (index) => const Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.xxl),
                      child: ProjectShimmer(),
                    ),
                  ),
                )
              else
                Column(
                  children: List.generate(
                    viewModel.projects.length,
                    (index) {
                      final project = viewModel.projects[index];
                      final isReversed = index % 2 != 0; // Alternating 0=Text Left, 1=Image Left
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                        child: ProjectCard(
                          project: project,
                          isReversed: isReversed,
                          onViewCaseStudy: () => _openDetail(context, project),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, project) {
    showDialog(
      context: context,
      builder: (context) => ProjectDetailDialog(project: project),
    );
  }
}
