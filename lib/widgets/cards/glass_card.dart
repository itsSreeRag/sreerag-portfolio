import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final bool isHovered;
  final ValueChanged<bool>? onHover;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.onTap,
    this.isHovered = false,
    this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover?.call(true),
      onExit: (_) => onHover?.call(false),
      cursor: onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          width: width,
          height: height,
          margin: margin,
          padding: padding ?? const EdgeInsets.all(24),
          transform: isHovered
              ? Matrix4.translationValues(0, -6, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: AppRadius.borderLg,
            border: Border.all(
              color: isHovered
                  ? AppColors.primaryLight.withValues(alpha: 0.4)
                  : AppColors.surfaceBorder,
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? AppColors.primaryGlow
                    : const Color(0x33000000),
                blurRadius: isHovered ? 20.0 : 12.0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
