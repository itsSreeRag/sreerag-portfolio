import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../widgets/loaders/timeline_shimmer.dart';
import '../../../widgets/typography/section_header.dart';
import '../viewmodels/experience_viewmodel.dart';
import '../widgets/experience_card.dart';

class ExperienceView extends StatelessWidget {
  const ExperienceView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.md : AppSpacing.xl,
        vertical: AppSpacing.xxl,
      ),
      child: Consumer<ExperienceViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Experience',
                subtitle: 'Hands-on software development training, project deliveries, and engineering roles.',
              ),
              const SizedBox(height: AppSpacing.xl),

              if (viewModel.isLoading)
                const TimelineShimmer()
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.experiences.length,
                  itemBuilder: (context, index) {
                    final exp = viewModel.experiences[index];
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
                          child: ExperienceCard(experience: exp),
                        ),
                      ],
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
