import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'particles_painter.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    for (int i = 0; i < 30; i++) {
      _particles.add(
        Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          radius: _random.nextDouble() * 2 + 1,
          speedX: _random.nextDouble() * 0.08,
          speedY: _random.nextDouble() * 0.15 + 0.04,
          opacity: _random.nextDouble() * 0.25 + 0.08,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark Base #0B111A
        Container(
          color: AppColors.background,
        ),

        // Ambient Top Right Circular Glow behind Profile (as in reference image)
        Positioned(
          top: -100,
          right: -80,
          child: Container(
            width: 600,
            height: 600,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color(0x331976D2),
                  Color(0x1A0B111A),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Ambient Left Glow
        Positioned(
          top: 400,
          left: -150,
          child: Container(
            width: 500,
            height: 500,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color(0x1FFF5252),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Subtle Canvas Floating Particles
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: ParticlesPainter(
                particles: _particles,
                animationValue: _controller.value,
              ),
            );
          },
        ),

        widget.child,
      ],
    );
  }
}
