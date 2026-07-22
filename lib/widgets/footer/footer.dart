import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/url_launcher_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../buttons/social_button.dart';

class Footer extends StatelessWidget {
  final Function(String) onNavClick;

  const Footer({
    super.key,
    required this.onNavClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.xxl,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppConstants.name,
            style: AppTypography.titleLarge(color: Colors.white).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Designed with passion, all rights reserved for Sreerag.',
            style: AppTypography.bodyMedium(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Social icons matching reference image (Email, GitHub, LinkedIn)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialButton(
                icon: Icons.email_rounded,
                tooltip: 'Email',
                onPressed: () => UrlLauncherService.openEmail(AppConstants.email),
              ),
              const SizedBox(width: AppSpacing.md),
              SocialButton(
                icon: FontAwesomeIcons.github,
                tooltip: 'GitHub',
                onPressed: () => UrlLauncherService.openUrl(AppConstants.githubUrl),
              ),
              const SizedBox(width: AppSpacing.md),
              SocialButton(
                icon: FontAwesomeIcons.linkedin,
                tooltip: 'LinkedIn',
                onPressed: () => UrlLauncherService.openUrl(AppConstants.linkedinUrl),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
