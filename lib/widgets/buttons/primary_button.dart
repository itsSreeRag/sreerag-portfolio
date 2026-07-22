import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_typography.dart';

class PrimaryButton extends StatefulWidget {
  final String text;
  final dynamic icon;
  final VoidCallback onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.dotAccent : const Color(0xFFFF5252),
            borderRadius: AppRadius.borderSm,
            boxShadow: [
              BoxShadow(
                color: _isHovered ? AppColors.dotAccentGlow : Colors.transparent,
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading) ...[
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
              ] else if (widget.icon != null) ...[
                _buildIconWidget(widget.icon!),
                const SizedBox(width: 10),
              ],
              Text(
                widget.text,
                style: AppTypography.labelLarge(color: Colors.white).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWidget(dynamic icon) {
    if (icon is IconData) {
      return Icon(icon, color: Colors.white, size: 18);
    } else if (icon is Widget) {
      return icon;
    } else {
      return FaIcon(icon, color: Colors.white, size: 18);
    }
  }
}
