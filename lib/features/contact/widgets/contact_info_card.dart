import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../widgets/cards/glass_card.dart';

class ContactInfoCard extends StatelessWidget {
  final dynamic icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const ContactInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.dotAccent.withValues(alpha: 0.15),
              borderRadius: AppRadius.borderMd,
            ),
            child: _buildIcon(icon),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTypography.caption(color: AppColors.textMuted),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTypography.titleMedium(color: Colors.white).copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
        ],
      ),
    );
  }

  Widget _buildIcon(dynamic icon) {
    const color = AppColors.dotAccent;
    if (icon is IconData) {
      return Icon(icon, color: color, size: 20);
    } else if (icon is Widget) {
      return icon;
    } else {
      return FaIcon(icon, color: color, size: 20);
    }
  }
}
