import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/buttons/secondary_button.dart';

/// Renders action buttons in the hero section: "Got a project?" and "My resume"
class HeroActionButtons extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onContactMe;
  final VoidCallback onResumePressed;

  const HeroActionButtons({
    super.key,
    required this.isMobile,
    required this.onContactMe,
    required this.onResumePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        PrimaryButton(
          text: 'Got a project?',
          onPressed: onContactMe,
        ),
        SecondaryButton(
          text: 'My resume',
          onPressed: onResumePressed,
        ),
      ],
    );
  }
}
