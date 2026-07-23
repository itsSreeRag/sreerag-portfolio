import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../models/experience_model.dart';
import 'experience_card.dart';

/// Single experience item with timeline dot, vertical line connector, and bottom spacing between items
class ExperienceTimelineItem extends StatelessWidget {
  final ExperienceModel experience;
  final bool isMobile;
  final bool isLast;

  const ExperienceTimelineItem({
    super.key,
    required this.experience,
    required this.isMobile,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 36),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile) ...[
              Column(
                children: [
                  const SizedBox(height: 4),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: AppColors.dotAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: AppColors.dotAccent.withValues(alpha: 0.25),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: AppSpacing.lg),
            ],
            Expanded(
              child: ExperienceCard(experience: experience),
            ),
          ],
        ),
      ),
    );
  }
}
