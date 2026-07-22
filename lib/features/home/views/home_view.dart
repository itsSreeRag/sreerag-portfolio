import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_spacing.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/hero_profile_avatar.dart';
import '../widgets/hero_text_content.dart';

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
              // Hero Content Left
              Expanded(
                flex: isMobile ? 0 : 6,
                child: HeroTextContent(
                  isMobile: isMobile,
                  viewModel: viewModel,
                  onContactMe: onContactMe,
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
