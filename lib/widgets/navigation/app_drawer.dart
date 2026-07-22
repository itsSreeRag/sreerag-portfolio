import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/url_launcher_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../buttons/primary_button.dart';

class AppDrawer extends StatelessWidget {
  final List<String> items;
  final int activeIndex;
  final Function(String) onItemSelected;

  const AppDrawer({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.lg),
          bottomLeft: Radius.circular(AppRadius.lg),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.dotAccent,
                          borderRadius: AppRadius.borderMd,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.dotAccentGlow,
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'S',
                          style: AppTypography.titleLarge(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('Sreerag.dev', style: AppTypography.titleLarge()),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Divider(color: AppColors.divider, height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final title = items[index];
                    final isActive = index == activeIndex;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.borderMd,
                      ),
                      tileColor: isActive
                          ? AppColors.dotAccent.withValues(alpha: 0.15)
                          : Colors.transparent,
                      leading: _buildIcon(
                        _getIconForSection(title),
                        isActive ? AppColors.dotAccent : AppColors.textMuted,
                      ),
                      title: Text(
                        title,
                        style: AppTypography.labelLarge(
                          color: isActive
                              ? AppColors.dotAccent
                              : AppColors.textPrimary,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        onItemSelected(title);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                text: 'Hire Me',
                icon: Icons.send_rounded,
                onPressed: () {
                  Navigator.of(context).pop();
                  UrlLauncherService.openEmail(
                    AppConstants.email,
                    subject: 'Job Opportunity',
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        UrlLauncherService.openUrl(AppConstants.githubUrl),
                  ),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.linkedin,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        UrlLauncherService.openUrl(AppConstants.linkedinUrl),
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        UrlLauncherService.openUrl(AppConstants.whatsappUrl),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic _getIconForSection(String section) {
    switch (section) {
      case 'Home':
        return Icons.home_rounded;
      case 'About':
        return Icons.person_rounded;
      case 'Skills':
        return Icons.code_rounded;
      case 'Projects':
        return Icons.work_rounded;
      case 'Experience':
        return Icons.business_center_rounded;
      case 'Contact':
        return Icons.mail_rounded;
      default:
        return Icons.grid_view_rounded;
    }
  }

  Widget _buildIcon(dynamic icon, Color color) {
    if (icon is IconData) {
      return Icon(icon, color: color);
    } else if (icon is Widget) {
      return icon;
    } else {
      return FaIcon(icon, color: color);
    }
  }
}
