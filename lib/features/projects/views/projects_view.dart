import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../models/project_model.dart';
import '../viewmodels/projects_viewmodel.dart';
import '../widgets/project_detail_dialog.dart';
import '../widgets/projects_header.dart';
import '../widgets/projects_list.dart';

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
              // Centered Section Header
              const ProjectsHeader(),
              const SizedBox(height: 64),

              // Projects List or Shimmer Loading State
              ProjectsList(
                isLoading: viewModel.isLoading,
                projects: viewModel.projects,
                onViewCaseStudy: (project) => _openDetail(context, project),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, ProjectModel project) {
    showDialog(
      context: context,
      builder: (context) => ProjectDetailDialog(project: project),
    );
  }
}
