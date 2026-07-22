import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class StatCard extends StatefulWidget {
  final int countValue;
  final String symbol;
  final String label;
  final double countProgress;
  final double symbolScale;
  final double labelOpacity;
  final double labelOffsetY;

  const StatCard({
    super.key,
    required this.countValue,
    this.symbol = '+',
    required this.label,
    required this.countProgress,
    required this.symbolScale,
    required this.labelOpacity,
    required this.labelOffsetY,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final int displayedCount =
        (widget.countValue * widget.countProgress).round();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: _isHovered
            ? Matrix4.diagonal3Values(1.03, 1.03, 1.0)
            : Matrix4.identity(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _isHovered
              ? Colors.white.withValues(alpha: 0.04)
              : Colors.transparent,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.dotAccent.withValues(alpha: 0.25),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '$displayedCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(width: 4),
                Transform.scale(
                  scale: widget.symbolScale,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.symbol,
                    style: const TextStyle(
                      color: AppColors.dotAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Transform.translate(
              offset: Offset(0, widget.labelOffsetY),
              child: Opacity(
                opacity: widget.labelOpacity,
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.35,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




