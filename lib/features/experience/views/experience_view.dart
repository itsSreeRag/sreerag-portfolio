import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../widgets/typography/section_header.dart';
import '../viewmodels/experience_viewmodel.dart';
import '../widgets/experience_timeline_list.dart';

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
                subtitle:
                    'My professional journey as a Flutter developer, building real-world applications and delivering production features.',
              ),
              const SizedBox(height: AppSpacing.xl),

              ExperienceTimelineList(
                isLoading: viewModel.isLoading,
                experiences: viewModel.experiences,
                isMobile: isMobile,
              ),
            ],
          );
        },
      ),
    );
  }
}
