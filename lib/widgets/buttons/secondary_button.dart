import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_typography.dart';

class SecondaryButton extends StatefulWidget {
  final String text;
  final dynamic icon;
  final VoidCallback onPressed;

  const SecondaryButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: AppRadius.borderSm,
            border: Border.all(
              color: _isHovered ? Colors.white : Colors.white.withValues(alpha: 0.3),
              width: 1.2,
            ),
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                _buildIconWidget(widget.icon!),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: AppTypography.labelLarge(
                  color: _isHovered ? Colors.white : AppColors.textSecondary,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWidget(dynamic icon) {
    final color = _isHovered ? Colors.white : AppColors.textSecondary;
    if (icon is IconData) {
      return Icon(icon, color: color, size: 16);
    } else if (icon is Widget) {
      return icon;
    } else {
      return FaIcon(icon, color: color, size: 16);
    }
  }
}
