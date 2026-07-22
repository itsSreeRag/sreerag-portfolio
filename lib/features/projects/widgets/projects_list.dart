import 'package:flutter/material.dart';
import '../../../models/project_model.dart';
import '../../../widgets/loaders/project_shimmer.dart';
import 'project_card.dart';

class ProjectsList extends StatelessWidget {
  final bool isLoading;
  final List<ProjectModel> projects;
  final void Function(ProjectModel project) onViewCaseStudy;

  const ProjectsList({
    super.key,
    required this.isLoading,
    required this.projects,
    required this.onViewCaseStudy,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column(
        children: List.generate(
          3,
          (index) => const Padding(
            padding: EdgeInsets.only(bottom: 64),
            child: ProjectShimmer(),
          ),
        ),
      );
    }

    return Column(
      children: List.generate(
        projects.length,
        (index) {
          final project = projects[index];
          final isReversed = index % 2 != 0; // Alternating 0=Text Left, 1=Image Left
          return ProjectCard(
            project: project,
            isReversed: isReversed,
            onViewCaseStudy: () => onViewCaseStudy(project),
          );
        },
      ),
    );
  }
}
