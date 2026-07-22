import 'dart:math';
import 'package:flutter/material.dart';

class Particle {
  double x;
  double y;
  double radius;
  double speedY;
  double speedX;
  double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speedY,
    required this.speedX,
    required this.opacity,
  });
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;

  ParticlesPainter({
    required this.particles,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    for (final particle in particles) {
      final double progressX = (particle.x + sin(animationValue * 2 * pi + particle.y) * 0.05) % 1.0;
      final double progressY = (particle.y - animationValue * particle.speedY) % 1.0;

      final double actualX = (progressX < 0 ? progressX + 1.0 : progressX) * size.width;
      final double actualY = (progressY < 0 ? progressY + 1.0 : progressY) * size.height;

      paint.color = const Color(0xFF1976D2).withValues(alpha: particle.opacity);
      canvas.drawCircle(Offset(actualX, actualY), particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlesPainter oldDelegate) => true;
}
