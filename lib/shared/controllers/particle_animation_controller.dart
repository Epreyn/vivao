// lib/shared/controllers/particle_animation_controller.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Modèle pour une particule de type "sparkle" avec trail
class SparkleParticle {
  final String id;
  final Offset position;
  final double initialSize;
  final Color color;
  final double angle;
  final int groupIndex;
  final int particleIndex;
  final List<Offset> trail;

  SparkleParticle({
    required this.id,
    required this.position,
    required this.initialSize,
    required this.color,
    required this.angle,
    required this.groupIndex,
    required this.particleIndex,
    List<Offset>? trail,
  }) : trail = trail ?? [];

  SparkleParticle copyWith({List<Offset>? trail}) {
    return SparkleParticle(
      id: id,
      position: position,
      initialSize: initialSize,
      color: color,
      angle: angle,
      groupIndex: groupIndex,
      particleIndex: particleIndex,
      trail: trail ?? this.trail,
    );
  }
}

class ParticleAnimationController extends GetxController
    with GetTickerProviderStateMixin {
  // Animation principale
  late AnimationController animationController;
  late Animation<double> opacityAnimation;
  late Animation<double> spreadAnimation;

  // Liste observable des particules
  final RxList<SparkleParticle> particles = <SparkleParticle>[].obs;

  // État de l'animation
  final RxBool isAnimating = false.obs;

  // Centre et taille du bouton
  Offset animationCenter = Offset.zero;
  Size buttonSize = Size.zero;

  // Configuration
  final int groupCount;
  final int particlesPerGroup;
  final double sparkleSize;
  final Duration animationDuration;
  final List<Color> particleColors;
  final double spreadDistance;
  final int trailLength;

  // Compteur pour les mises à jour du trail
  int frameCount = 0;

  ParticleAnimationController({
    this.groupCount = 12, // Optimal pour la performance
    this.particlesPerGroup = 1,
    this.sparkleSize = 3.5,
    this.animationDuration = const Duration(milliseconds: 600),
    this.particleColors = const [],
    this.spreadDistance = 30,
    this.trailLength = 4, // Trail plus court pour la performance
  });

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: animationDuration,
      vsync: this,
    );

    // Animation d'opacité simple
    opacityAnimation = animationController.drive(
      Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeOut)),
    );

    // Animation de dispersion
    spreadAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutCubic),
    );

    // Listener pour mettre à jour les trails
    animationController.addListener(_updateTrails);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isAnimating.value = false;
        particles.clear();
        frameCount = 0;
      }
    });
  }

  void _updateTrails() {
    frameCount++;
    if (frameCount % 2 != 0)
      return; // Mise à jour tous les 2 frames pour la performance

    final updatedParticles = <SparkleParticle>[];

    for (final particle in particles) {
      // Position actuelle de la particule
      final spreadOffset = spreadAnimation.value * spreadDistance;
      final currentX =
          particle.position.dx + cos(particle.angle) * spreadOffset;
      final currentY =
          particle.position.dy + sin(particle.angle) * spreadOffset;
      final currentPosition = Offset(currentX, currentY);

      // Mettre à jour le trail
      final newTrail = [currentPosition, ...particle.trail];
      if (newTrail.length > trailLength) {
        newTrail.removeLast();
      }

      updatedParticles.add(particle.copyWith(trail: newTrail));
    }

    particles.value = updatedParticles;
  }

  void triggerAnimation({
    required Offset center,
    required Size size,
    List<Color>? customColors,
  }) {
    if (isAnimating.value) return;

    isAnimating.value = true;
    animationCenter = center;
    buttonSize = size;
    particles.clear();
    frameCount = 0;

    final random = Random();
    final colors = customColors ?? particleColors;
    final baseAngle = 360.0 / groupCount;

    // Calculer le rayon pour positionner les particules autour du bouton carré
    // Pour un bouton carré, on utilise la demi-diagonale pour bien couvrir les coins
    final cornerRadius = sqrt(pow(size.width / 2, 2) + pow(size.height / 2, 2));
    final buttonRadius = cornerRadius + 8; // +8 pour être juste à l'extérieur

    // Générer les particules en groupes autour du bouton
    for (int i = 0; i < groupCount; i++) {
      final groupAngle = (i * baseAngle) * (pi / 180);

      // Couleur du groupe (effet arc-en-ciel)
      final Color groupColor;
      if (colors.isNotEmpty) {
        groupColor = colors[i % colors.length];
      } else {
        // Génération de couleurs arc-en-ciel vives
        final hue = (i * baseAngle) % 360;
        groupColor = HSLColor.fromAHSL(
          1.0,
          hue,
          0.9,
          0.65,
        ).toColor(); // Saturation haute, luminosité équilibrée
      }

      for (int j = 0; j < particlesPerGroup; j++) {
        // Position sur le contour du bouton avec légère variation
        final angleVariation = (j - 0.5) * 0.15;
        final particleAngle = groupAngle + angleVariation;

        // Position de départ sur le contour extérieur du bouton
        final startRadius = buttonRadius + 3 + random.nextDouble() * 2;
        final particleX = center.dx + startRadius * cos(particleAngle);
        final particleY = center.dy + startRadius * sin(particleAngle);

        // Angle de dispersion avec légère variation
        final disperseAngle = particleAngle + (random.nextDouble() - 0.5) * 0.2;

        particles.add(
          SparkleParticle(
            id: 'sparkle_${i}_$j',
            position: Offset(particleX, particleY),
            initialSize: sparkleSize * (0.8 + random.nextDouble() * 0.4),
            color: groupColor,
            angle:
                disperseAngle, // Utiliser l'angle de dispersion avec variation
            groupIndex: i,
            particleIndex: j,
            trail: [],
          ),
        );
      }
    }

    // Démarrer l'animation
    animationController.forward(from: 0);
  }

  @override
  void onClose() {
    animationController.removeListener(_updateTrails);
    animationController.dispose();
    super.onClose();
  }
}
