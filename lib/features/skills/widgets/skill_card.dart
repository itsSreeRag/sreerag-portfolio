import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/skill_model.dart';
import '../../../widgets/cards/glass_card.dart';

class SkillCard extends StatefulWidget {
  final SkillModel skill;

  const SkillCard({
    super.key,
    required this.skill,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      isHovered: _isHovered,
      onHover: (hovered) => setState(() => _isHovered = hovered),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: AppRadius.borderMd,
                ),
                child: _buildIcon(widget.skill.icon),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.skill.name,
                      style: AppTypography.titleMedium(),
                    ),
                    Text(
                      widget.skill.category.label,
                      style: AppTypography.caption(color: AppColors.primaryLight),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.skill.description,
            style: AppTypography.caption(color: AppColors.textSecondary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: AppRadius.borderRound,
            child: LinearProgressIndicator(
              value: widget.skill.level,
              backgroundColor: AppColors.surfaceElevated,
              valueColor: AlwaysStoppedAnimation<Color>(
                _isHovered ? AppColors.accentCyan : AppColors.primaryLight,
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(dynamic icon) {
    const color = AppColors.primaryLight;
    if (icon is IconData) {
      return Icon(icon, color: color, size: 22);
    } else if (icon is Widget) {
      return icon;
    } else {
      return FaIcon(icon, color: color, size: 22);
    }
  }
}
