import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';

class BackToTopButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isVisible;

  const BackToTopButton({
    super.key,
    required this.onPressed,
    required this.isVisible,
  });

  @override
  State<BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<BackToTopButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: widget.isVisible ? 32 : -60,
      right: 32,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: widget.isVisible ? 1.0 : 0.0,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: AppRadius.borderRound,
                boxShadow: [
                  _isHovered ? AppShadows.glow : AppShadows.soft,
                ],
              ),
              transform: _isHovered
                  ? Matrix4.translationValues(0, -4, 0)
                  : Matrix4.identity(),
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
