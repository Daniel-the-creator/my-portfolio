import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int particleCount = 150;
  final List<Offset> particles = [];
  final Random random = Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    for (int i = 0; i < particleCount; i++) {
      particles.add(
        Offset(
          random.nextDouble(),
          random.nextDouble(),
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(particles, _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Offset> particles;
  final double animationValue;

  ParticlePainter(this.particles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF14B8A6).withOpacity(0.8) // Teal
      ..style = PaintingStyle.fill;
      
    final paint2 = Paint()
      ..color = const Color(0xFF3B82F6).withOpacity(0.8) // Blue
      ..style = PaintingStyle.fill;

    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];
      // Modulate speed slightly so they feel organic
      final speedMultiplier = (i % 3) + 1;
      final dx = (p.dx + (animationValue * 0.03 * speedMultiplier)) % 1.0;
      final dy = (p.dy + (animationValue * 0.03 * speedMultiplier)) % 1.0;

      final offset = Offset(dx * size.width, dy * size.height);
      
      final paint = i % 2 == 0 ? paint1 : paint2;
      canvas.drawCircle(offset, speedMultiplier.toDouble() * 2.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
