import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/services/url_launcher_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/buttons/secondary_button.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/hero_profile_avatar.dart';

class HomeView extends StatelessWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContactMe;

  const HomeView({
    super.key,
    required this.onViewProjects,
    required this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 550),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.md : AppSpacing.xl,
        vertical: AppSpacing.xxl,
      ),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Hero Content Left (exact reference crop image layout)
              Expanded(
                flex: isMobile ? 0 : 6,
                child: Column(
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Hello + round coral dot (reference uses a dot, not a period glyph)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Hello',
                          style:
                              (isMobile
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
                          style:
                              AppTypography.titleLarge(
                                color: AppColors.textSecondary,
                              ).copyWith(
                                fontSize: isMobile ? 20 : 24,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Software Developer title
                    Text(
                      viewModel.currentRole,
                      style:
                          (isMobile
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

                    // Action buttons: Got a project? & My resume (exact reference styling)
                    Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.md,
                      alignment: isMobile
                          ? WrapAlignment.center
                          : WrapAlignment.start,
                      children: [
                        PrimaryButton(
                          text: 'Got a project?',
                          onPressed: onContactMe,
                        ),
                        SecondaryButton(
                          text: 'My resume',
                          onPressed: () {
                            UrlLauncherService.openUrl(AppConstants.resumeUrl);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (isMobile) const SizedBox(height: AppSpacing.xxl),

              // Hero Profile Avatar Right
              Expanded(
                flex: isMobile ? 0 : 5,
                child: Center(child: HeroProfileAvatar(isMobile: isMobile)),
              ),
            ],
          );
        },
      ),
    );
  }
}
