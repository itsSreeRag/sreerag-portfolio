import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Renders the hero greeting section: "Hello ." and "— I'm Sreerag"
class HeroGreetingText extends StatelessWidget {
  final bool isMobile;

  const HeroGreetingText({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Hello + round coral dot (reference uses a dot, not a period glyph)
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Hello',
              style: (isMobile
                      ? AppTypography.displayMedium()
                      : AppTypography.displayLarge())
                  .copyWith(
                fontSize: isMobile ? 42 : 56,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(width: isMobile ? 8 : 10),
            Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 8 : 10),
              child: Container(
                width: isMobile ? 8 : 10,
                height: isMobile ? 8 : 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.dotAccent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Red accent line + I'm Sreerag (exact reference line + text)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 1.5,
              color: AppColors.dotAccent,
            ),
            const SizedBox(width: 14),
            Text(
              "I'm ${AppConstants.name}",
              style: AppTypography.titleLarge(
                color: AppColors.textSecondary,
              ).copyWith(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
