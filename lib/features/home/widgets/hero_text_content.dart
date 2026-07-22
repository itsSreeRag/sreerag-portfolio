import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../viewmodels/home_viewmodel.dart';
import 'hero_action_buttons.dart';
import 'hero_greeting_text.dart';

/// Hero Content Left Section: Greeting, name, dynamic role title, and action buttons.
class HeroTextContent extends StatelessWidget {
  final bool isMobile;
  final HomeViewModel viewModel;
  final VoidCallback onContactMe;

  const HeroTextContent({
    super.key,
    required this.isMobile,
    required this.viewModel,
    required this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Greeting & Name
        HeroGreetingText(isMobile: isMobile),
        const SizedBox(height: AppSpacing.sm),

        // Dynamic Role Title
        Text(
          viewModel.currentRole,
          style: (isMobile
                  ? AppTypography.displayMedium(
                      color: Colors.white,
                    )
                  : AppTypography.displayLarge(
                      color: Colors.white,
                    ))
              .copyWith(
            fontSize: isMobile ? 36 : 56,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -0.5,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: AppSpacing.xxl),

        // Action buttons: Got a project? & My resume
        HeroActionButtons(
          isMobile: isMobile,
          onContactMe: onContactMe,
          onResumePressed: viewModel.openResume,
        ),
      ],
    );
  }
}
