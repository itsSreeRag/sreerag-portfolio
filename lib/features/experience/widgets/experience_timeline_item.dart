import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../models/experience_model.dart';
import 'experience_card.dart';

/// Single experience item with optional left timeline dot and vertical line connector
class ExperienceTimelineItem extends StatelessWidget {
  final ExperienceModel experience;
  final bool isMobile;

  const ExperienceTimelineItem({
    super.key,
    required this.experience,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile) ...[
          Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: AppColors.dotAccent,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 220,
                color: AppColors.dotAccent.withValues(alpha: 0.25),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.lg),
        ],
        Expanded(
          child: ExperienceCard(experience: experience),
        ),
      ],
    );
  }
}
