import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/services/url_launcher_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/project_model.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/buttons/secondary_button.dart';

class ProjectDetailDialog extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailDialog({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 750),
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: AppRadius.borderLg,
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      project.title,
                      style: AppTypography.titleLarge(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              ClipRRect(
                borderRadius: AppRadius.borderMd,
                child: SizedBox(
                  height: 260,
                  width: double.infinity,
                  child: Image.network(
                    project.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Architecture & Overview',
                style: AppTypography.titleMedium(color: AppColors.primaryLight),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                project.detailedDescription,
                style: AppTypography.bodyLarge(),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Key Features & Functionalities',
                style: AppTypography.titleMedium(color: AppColors.primaryLight),
              ),
              const SizedBox(height: AppSpacing.sm),
              ...project.features.map(
                (feat) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.secondary, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(feat, style: AppTypography.bodyMedium(color: AppColors.textPrimary)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (project.githubUrl != null) ...[
                    SecondaryButton(
                      text: 'View Code',
                      icon: FontAwesomeIcons.github,
                      onPressed: () => UrlLauncherService.openUrl(project.githubUrl!),
                    ),
                    const SizedBox(width: AppSpacing.md),
                  ],
                  if (project.liveDemoUrl != null)
                    PrimaryButton(
                      text: 'Launch Project',
                      icon: Icons.open_in_new_rounded,
                      onPressed: () => UrlLauncherService.openUrl(project.liveDemoUrl!),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
