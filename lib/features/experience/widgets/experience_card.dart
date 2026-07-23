import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/experience_model.dart';
import '../../../widgets/cards/glass_card.dart';

class ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.role,
                      style: AppTypography.titleLarge(
                        color: Colors.white,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${experience.company} • ${experience.location}',
                      style: AppTypography.titleMedium(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.dotAccent.withValues(alpha: 0.15),
                  borderRadius: AppRadius.borderRound,
                  border: Border.all(
                    color: AppColors.dotAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  experience.duration,
                  style: AppTypography.caption(
                    color: AppColors.dotAccent,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Text(
          //   'Key Responsibilities & Contributions:',
          //   style: AppTypography.labelLarge(color: AppColors.textSecondary),
          // ),
          // const SizedBox(height: AppSpacing.sm),
          // ...experience.responsibilities.map(
          //   (resp) => Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 4),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const Icon(Icons.arrow_right_rounded, color: AppColors.dotAccent, size: 20),
          //         const SizedBox(width: 8),
          //         Expanded(
          //           child: Text(
          //             resp,
          //             style: AppTypography.bodyMedium(color: Colors.white),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(height: AppSpacing.md),
          // Wrap(
          //   spacing: 8,
          //   runSpacing: 6,
          //   children: experience.technologies
          //       .map((tech) => Container(
          //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          //             decoration: BoxDecoration(
          //               color: Colors.white.withValues(alpha: 0.05),
          //               borderRadius: AppRadius.borderRound,
          //               border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          //             ),
          //             child: Text(
          //               tech,
          //               style: AppTypography.caption(color: AppColors.textSecondary),
          //             ),
          //           ))
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}
