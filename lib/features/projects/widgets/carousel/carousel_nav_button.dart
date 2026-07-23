import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class CarouselNavButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  const CarouselNavButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  @override
  State<CarouselNavButton> createState() => _CarouselNavButtonState();
}

class _CarouselNavButtonState extends State<CarouselNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered
                ? AppColors.dotAccent
                : Colors.black.withValues(alpha: 0.5),
            border: Border.all(
              color: _isHovered
                  ? AppColors.dotAccent
                  : Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.dotAccent.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            widget.icon,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
