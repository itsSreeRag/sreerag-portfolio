import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/responsive/responsive_breakpoints.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../viewmodels/about_viewmodel.dart';
import '../widgets/stat_card.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxl,
        vertical: isMobile ? 48 : 80,
      ),
      child: Consumer<AboutViewModel>(
        builder: (context, viewModel, child) {
          return Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Column: Timeline Services with Sreerag's services
              Expanded(
                flex: isMobile ? 0 : 5,
                child: _buildTimelineServices(isMobile),
              ),

              if (isMobile)
                const SizedBox(height: 48)
              else
                const SizedBox(width: 60),

              // Right Column: About Me heading, Sreerag's bio & stats
              Expanded(
                flex: isMobile ? 0 : 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 36 : 44,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppConstants.bioFull,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 15.5,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Sreerag's Stats Row
                    Wrap(
                      spacing: isMobile ? 32 : 48,
                      runSpacing: 24,
                      children: const [
                        StatCard(
                          value: '3',
                          symbol: '+',
                          label: 'Years of\nexperience',
                        ),
                        StatCard(
                          value: '10',
                          symbol: '+',
                          label: 'Completed\nProjects',
                        ),
                        StatCard(
                          value: '100',
                          symbol: '%',
                          label: 'Client\nsatisfaction',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimelineServices(bool isMobile) {
    return Column(
      children: [
        _buildTimelineItem(
          icon: Icons.flutter_dash_rounded,
          title: 'Flutter Development',
          subtitle: 'Cross-platform iOS, Android, and Desktop apps',
        ),
        _buildTimelineItem(
          icon: Icons.phone_iphone_rounded,
          title: 'Mobile Applications',
          subtitle: 'Native feel with pixel-perfect UI & state management',
        ),
        _buildTimelineItem(
          icon: Icons.desktop_windows_outlined,
          title: 'Windows Desktop Systems',
          subtitle: 'High-performance desktop apps & local storage',
        ),
        _buildTimelineItem(
          icon: Icons.api_rounded,
          title: 'REST API & Firebase',
          subtitle: 'Cloud syncing, auth, and real-time backend services',
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return SizedBox(
      height: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Vertical red timeline line & dot
          SizedBox(
            width: 20,
            height: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Red vertical line running through
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 2,
                      color: AppColors.dotAccent,
                    ),
                  ),
                ),
                // Red dot on the line
                Container(
                  width: 8,
                  height: 8,
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
          ),
          const SizedBox(width: 24),

          // Service Icon Container
          Container(
            width: 46,
            height: 46,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              size: 24,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 18),

          // Service Title & Subtitle
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


