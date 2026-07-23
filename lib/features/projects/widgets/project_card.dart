import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/services/url_launcher_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/project_model.dart';
import 'project_image_carousel.dart';

class ProjectCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    // Text Content Column
    final textContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Project Title
        Text(
          project.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 24 : 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),

        // Tech Pill Badges
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies
              .map(
                (tech) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tech,
                    style: const TextStyle(
                      color: Color(0xFFCBD5E1),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 20),

        // Project Short Description
        Text(
          project.shortDescription,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 15.5,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 28),

        // Action Buttons / Links
        Wrap(
          spacing: 20,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Solid Red Primary Button: View Github
            if (project.githubUrl != null)
              ElevatedButton.icon(
                onPressed: () =>
                    UrlLauncherService.openUrl(project.githubUrl!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.dotAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                icon: const FaIcon(FontAwesomeIcons.github, size: 17),
                label: const Text(
                  'View Github',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            // Text Link with Arrow: View project ↗
            if (project.liveDemoUrl != null)
              InkWell(
                onTap: () =>
                    UrlLauncherService.openUrl(project.liveDemoUrl!),
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'View project',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.north_east_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

            // Case Study link
            TextButton.icon(
              onPressed: onViewCaseStudy,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF94A3B8),
              ),
              icon: const Icon(Icons.article_outlined, size: 18),
              label: const Text(
                'Case Study',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );

    // Image Carousel Container
    final imageContent = ProjectImageCarousel(
      images: project.images,
      isMobile: isMobile,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 80),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageContent,
                const SizedBox(height: 24),
                textContent,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: isReversed
                  ? [
                      Expanded(flex: 6, child: imageContent),
                      const SizedBox(width: 48),
                      Expanded(flex: 5, child: textContent),
                    ]
                  : [
                      Expanded(flex: 5, child: textContent),
                      const SizedBox(width: 48),
                      Expanded(flex: 6, child: imageContent),
                    ],
            ),
    );
  }
}
