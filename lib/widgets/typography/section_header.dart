import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? badge;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Small Accent Line indicator (like reference image)
        Container(
          width: 36,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.dotAccent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Section Title
        Text(
          title,
          style: AppTypography.displayMedium(color: Colors.white).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),

        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle!,
            style: AppTypography.bodyLarge(color: AppColors.textSecondary),
          ),
        ],
      ],
    );
  }
}
