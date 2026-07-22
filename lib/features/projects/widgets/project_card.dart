import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/services/url_launcher_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/project_model.dart';

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
  bool _isImageHovered = false;

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
          widget.project.title,
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
          children: widget.project.technologies
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
          widget.project.shortDescription,
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 15.5,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 28),

        // Action Buttons / Links (matching reference image)
        Wrap(
          spacing: 20,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Solid Red Primary Button: View Github
            if (widget.project.githubUrl != null)
              ElevatedButton.icon(
                onPressed: () =>
                    UrlLauncherService.openUrl(widget.project.githubUrl!),
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
            if (widget.project.liveDemoUrl != null)
              InkWell(
                onTap: () =>
                    UrlLauncherService.openUrl(widget.project.liveDemoUrl!),
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
              onPressed: widget.onViewCaseStudy,
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

    // Image Framed Container
    final imageContent = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isImageHovered = true),
      onExit: (_) => setState(() => _isImageHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        height: isMobile ? 240 : 320,
        decoration: BoxDecoration(
          color: const Color(0xFF141C28),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isImageHovered
                ? AppColors.dotAccent.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isImageHovered
                  ? AppColors.dotAccent.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: AnimatedScale(
            scale: _isImageHovered ? 1.03 : 1.0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: Image.network(
              widget.project.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF141C28),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.code_rounded,
                      size: 48,
                      color: AppColors.dotAccent,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Project Preview',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
              children: widget.isReversed
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

