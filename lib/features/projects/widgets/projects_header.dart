import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Centered Projects section header matching reference design
class ProjectsHeader extends StatelessWidget {
  const ProjectsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Projects',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),

        // Vertical red line with accent dot below (matching reference image)
        Column(
          children: [
            Container(
              width: 2,
              height: 18,
              color: AppColors.dotAccent,
            ),
            const SizedBox(height: 4),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.dotAccent,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dotAccent,
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
