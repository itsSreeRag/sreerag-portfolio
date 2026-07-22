import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';

class SocialButton extends StatefulWidget {
  final dynamic icon;
  final String tooltip;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.primary
                  : AppColors.surfaceElevated.withValues(alpha: 0.8),
              borderRadius: AppRadius.borderMd,
              border: Border.all(
                color: _isHovered ? AppColors.primaryLight : AppColors.surfaceBorder,
              ),
              boxShadow: [
                if (_isHovered) AppShadows.glow,
              ],
            ),
            transform: _isHovered
                ? Matrix4.diagonal3Values(1.1, 1.1, 1.0)
                : Matrix4.identity(),
            child: Center(
              child: _buildIcon(widget.icon),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(dynamic icon) {
    final color = _isHovered ? Colors.white : AppColors.textSecondary;
    if (icon is IconData) {
      return Icon(icon, color: color, size: 20);
    } else if (icon is Widget) {
      return icon;
    } else {
      return FaIcon(icon, color: color, size: 20);
    }
  }
}
