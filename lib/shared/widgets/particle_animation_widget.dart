// lib/shared/widgets/particle_animation_widget.dart

import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/particle_animation_controller.dart';
import '../../core/theme/app_colors.dart';

class ParticleAnimationWidget extends StatelessWidget {
  final ParticleAnimationController controller;
  final Widget child;

  const ParticleAnimationWidget({
    super.key,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Le contenu principal (le bouton)
        child,

        // Les particules sparkle avec trails
        Obx(
          () => controller.isAnimating.value
              ? Positioned.fill(
                  child: IgnorePointer(
                    child: RepaintBoundary(
                      child: AnimatedBuilder(
                        animation: controller.animationController,
                        builder: (context, _) {
                          return CustomPaint(
                            painter: SparkleTrailPainter(
                              particles: controller.particles,
                              center: controller.animationCenter,
                              particleOpacity:
                                  controller.opacityAnimation.value,
                              spreadProgress: controller.spreadAnimation.value,
                              spreadDistance: controller.spreadDistance,
                            ),
                            size: Size.infinite,
                          );
                        },
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// Painter pour l'animation sparkle avec trails
class SparkleTrailPainter extends CustomPainter {
  final List<SparkleParticle> particles;
  final Offset center;
  final double particleOpacity;
  final double spreadProgress;
  final double spreadDistance;

  SparkleTrailPainter({
    required this.particles,
    required this.center,
    required this.particleOpacity,
    required this.spreadProgress,
    required this.spreadDistance,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Dessiner les particules avec leurs trails
    for (final particle in particles) {
      _drawParticleWithTrail(canvas, particle);
    }
  }

  void _drawParticleWithTrail(Canvas canvas, SparkleParticle particle) {
    // Position actuelle de la particule
    final spreadOffset = spreadProgress * spreadDistance;
    final currentX = particle.position.dx + cos(particle.angle) * spreadOffset;
    final currentY = particle.position.dy + sin(particle.angle) * spreadOffset;
    final currentPosition = Offset(currentX, currentY);

    // Dessiner le trail d'abord (derrière la particule)
    if (particle.trail.isNotEmpty) {
      _drawTrail(canvas, particle, currentPosition);
    }

    // Dessiner la particule principale
    _drawSparkle(canvas, particle, currentPosition);
  }

  void _drawTrail(
    Canvas canvas,
    SparkleParticle particle,
    Offset currentPosition,
  ) {
    final points = [currentPosition, ...particle.trail];
    if (points.length < 2) return;

    // Dessiner le trail comme une ligne simple avec dégradé
    for (int i = 0; i < points.length - 1; i++) {
      final segmentProgress = i / (points.length - 1);
      final segmentOpacity = particleOpacity * (1 - segmentProgress) * 0.7;

      if (segmentOpacity < 0.1) continue;

      // Épaisseur du trail
      final thickness =
          particle.initialSize * (1 - segmentProgress * 0.7) * 0.4;

      // Paint simple pour la performance
      final paint = Paint()
        ..color = particle.color.withOpacity(segmentOpacity)
        ..strokeWidth = thickness
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  void _drawSparkle(Canvas canvas, SparkleParticle particle, Offset position) {
    // Taille avec effet de réduction au fil du temps
    final sizeFactor = 1 - (spreadProgress * 0.5);
    final currentSize = particle.initialSize * sizeFactor;

    if (currentSize <= 0.5) return;

    // Glow simple pour la performance
    final glowPaint = Paint()
      ..color = particle.color.withOpacity(particleOpacity * 0.2)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Paint principal
    final paint = Paint()
      ..color = particle.color.withOpacity(particleOpacity)
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.translate(position.dx, position.dy);
    canvas.rotate(spreadProgress * pi);

    // Dessiner le glow
    canvas.drawCircle(Offset.zero, currentSize * 1.5, glowPaint);

    // Dessiner une étoile
    _drawStar(canvas, currentSize, paint);

    // Point central brillant
    final centerPaint = Paint()
      ..color = Colors.white.withOpacity(particleOpacity * 0.4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, currentSize * 0.2, centerPaint);

    canvas.restore();
  }

  void _drawStar(Canvas canvas, double size, Paint paint) {
    final path = Path();
    const int points = 6; // Étoile à 6 branches pour plus d'impact

    for (int i = 0; i < points * 2; i++) {
      final angle = (i * pi / points) - pi / 2;
      final r = i.isEven ? size : size * 0.5;
      final x = cos(angle) * r;
      final y = sin(angle) * r;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SparkleTrailPainter oldDelegate) {
    return oldDelegate.particleOpacity != particleOpacity ||
        oldDelegate.spreadProgress != spreadProgress;
  }
}
