import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/services/url_launcher_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/project_model.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/buttons/secondary_button.dart';
import '../../../widgets/cards/glass_card.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final bool isReversed;
  final VoidCallback onViewCaseStudy;

  const ProjectCard({
    super.key,
    required this.project,
    required this.isReversed,
    required this.onViewCaseStudy,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    // Text content widget
    final textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.project.title,
          style: AppTypography.displayMedium(color: Colors.white).copyWith(
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Rounded Tech Chips (matching reference image dark chips)
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.project.technologies
              .map(
                (tech) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: AppRadius.borderRound,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    tech,
                    style: AppTypography.caption(color: AppColors.textSecondary).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: AppSpacing.md),

        Text(
          widget.project.shortDescription,
          style: AppTypography.bodyLarge(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Action Buttons (matching reference image: View Github, View project ↗)
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            if (widget.project.githubUrl != null)
              PrimaryButton(
                text: 'View Github',
                icon: FontAwesomeIcons.github,
                onPressed: () => UrlLauncherService.openUrl(widget.project.githubUrl!),
              ),
            if (widget.project.liveDemoUrl != null)
              SecondaryButton(
                text: 'View project ↗',
                onPressed: () => UrlLauncherService.openUrl(widget.project.liveDemoUrl!),
              ),
            SecondaryButton(
              text: 'Case Study',
              icon: Icons.article_outlined,
              onPressed: widget.onViewCaseStudy,
            ),
          ],
        ),
      ],
    );

    // Screenshot image widget with hover zoom & dark glass container
    final imageContent = AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: const BoxConstraints(maxHeight: 320),
      decoration: BoxDecoration(
        borderRadius: AppRadius.borderLg,
        border: Border.all(
          color: _isHovered
              ? AppColors.dotAccent.withValues(alpha: 0.5)
              : AppColors.surfaceBorder,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: _isHovered ? AppColors.primaryGlow : const Color(0x66000000),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppRadius.borderLg,
        child: Image.network(
          widget.project.imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColors.surfaceElevated,
            height: 250,
            alignment: Alignment.center,
            child: const Icon(Icons.computer_rounded, size: 60, color: AppColors.primaryLight),
          ),
        ),
      ),
    );

    return GlassCard(
      isHovered: _isHovered,
      onHover: (h) => setState(() => _isHovered = h),
      padding: EdgeInsets.all(isMobile ? 18 : 32),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageContent,
                const SizedBox(height: AppSpacing.lg),
                textContent,
              ],
            )
          : Row(
              children: widget.isReversed
                  ? [
                      Expanded(flex: 6, child: imageContent),
                      const SizedBox(width: AppSpacing.xxl),
                      Expanded(flex: 5, child: textContent),
                    ]
                  : [
                      Expanded(flex: 5, child: textContent),
                      const SizedBox(width: AppSpacing.xxl),
                      Expanded(flex: 6, child: imageContent),
                    ],
            ),
    );
  }
}
