import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Custom Painter for Beam of Light traveling down vertical timeline
class TimelineBeamPainter extends CustomPainter {
  final double progress;
  final double beamOpacity;

  TimelineBeamPainter({
    required this.progress,
    required this.beamOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final Offset start = Offset(width / 2, 40);
    final Offset end = Offset(width / 2, height - 40);
    final double totalLen = height - 80;

    // 1. Inactive background track (faint dark red)
    final Paint inactivePaint = Paint()
      ..color = AppColors.dotAccent.withValues(alpha: 0.15)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, end, inactivePaint);

    if (progress <= 0) return;

    final double activeLen = totalLen * progress;
    final Offset activeEnd = Offset(width / 2, 40 + activeLen);

    // 2. Bright illuminated line behind the beam
    final Paint activePaint = Paint()
      ..color = AppColors.dotAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, activeEnd, activePaint);

    // 3. Subtle glow along illuminated line
    final Paint lineGlowPaint = Paint()
      ..color = AppColors.dotAccent.withValues(alpha: 0.4)
      ..strokeWidth = 6.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, activeEnd, lineGlowPaint);

    // 4. Traveling Beam Head (energy core + bloom + outer glow)
    if (beamOpacity > 0.01 && activeLen > 0 && activeLen <= totalLen) {
      final Paint bloomPaint = Paint()
        ..color = const Color(0xFFE63946).withValues(alpha: 0.7 * beamOpacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(activeEnd, 8.0, bloomPaint);

      final Paint corePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.95 * beamOpacity);
      canvas.drawCircle(activeEnd, 3.5, corePaint);
    }
  }

  @override
  bool shouldRepaint(covariant TimelineBeamPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.beamOpacity != beamOpacity;
  }
}
