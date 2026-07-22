import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../widgets/loaders/project_shimmer.dart';
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
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxl,
        vertical: isMobile ? 48 : 80,
      ),
      child: Consumer<ProjectsViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Centered Section Header (matching reference image)
              const _ProjectsHeader(),
              const SizedBox(height: 64),

              if (viewModel.isLoading)
                Column(
                  children: List.generate(
                    3,
                    (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 64),
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
                      return ProjectCard(
                        project: project,
                        isReversed: isReversed,
                        onViewCaseStudy: () => _openDetail(context, project),
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

class _ProjectsHeader extends StatelessWidget {
  const _ProjectsHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Projects',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),

        // Vertical red line with accent dot below (matching reference image)
        Column(
          children: [
            Container(
              width: 2,
              height: 18,
              color: AppColors.dotAccent,
            ),
            const SizedBox(height: 4),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.dotAccent,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dotAccent,
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

