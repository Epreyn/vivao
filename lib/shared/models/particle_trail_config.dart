// lib/shared/models/particle_trail_config.dart

import 'package:flutter/material.dart';

/// Configuration pour personnaliser l'apparence des trails de particules
class ParticleTrailConfig {
  /// Activer ou désactiver les trails
  final bool enableTrails;

  /// Longueur maximale du trail (nombre de points)
  final int trailLength;

  /// Épaisseur du trail par rapport à la taille de la particule
  final double trailThicknessRatio;

  /// Opacité maximale du trail
  final double trailOpacity;

  /// Activer l'effet de glow autour du trail
  final bool enableGlow;

  /// Intensité du glow (blur radius)
  final double glowIntensity;

  /// Courbe d'animation pour le mouvement des particules
  final Curve animationCurve;

  /// Forme des particules
  final ParticleShape particleShape;

  /// Activer l'effet de gradient sur les particules
  final bool enableGradient;

  const ParticleTrailConfig({
    this.enableTrails = true,
    this.trailLength = 12,
    this.trailThicknessRatio = 0.8,
    this.trailOpacity = 0.6,
    this.enableGlow = true,
    this.glowIntensity = 4.0,
    this.animationCurve = Curves.easeOutCubic,
    this.particleShape = ParticleShape.star,
    this.enableGradient = true,
  });

  /// Configuration ultra-optimisée pour éviter les lags
  static const ParticleTrailConfig ultraLight = ParticleTrailConfig(
    enableTrails: true,
    trailLength: 4, // Très court
    trailThicknessRatio: 0.6,
    trailOpacity: 0.4,
    enableGlow: false,
    glowIntensity: 0,
    animationCurve: Curves.linear, // Plus simple
    particleShape: ParticleShape.circle,
    enableGradient: false,
  );

  /// Configuration prédéfinie optimisée pour la performance
  static const ParticleTrailConfig optimized = ParticleTrailConfig(
    enableTrails: true,
    trailLength: 6,
    trailThicknessRatio: 0.7,
    trailOpacity: 0.5,
    enableGlow: false, // Désactivé pour la performance
    glowIntensity: 0,
    animationCurve: Curves.easeOut,
    particleShape: ParticleShape.circle, // Forme simple
    enableGradient: false, // Désactivé pour la performance
  );

  /// Configuration prédéfinie pour un effet "feu d'artifice"
  static const ParticleTrailConfig fireworks = ParticleTrailConfig(
    enableTrails: true,
    trailLength: 8,
    trailThicknessRatio: 0.8,
    trailOpacity: 0.6,
    enableGlow: false,
    glowIntensity: 0,
    animationCurve: Curves.easeOutCubic,
    particleShape: ParticleShape.star,
    enableGradient: false,
  );

  /// Configuration prédéfinie pour un effet "comète"
  static const ParticleTrailConfig comet = ParticleTrailConfig(
    enableTrails: true,
    trailLength: 10,
    trailThicknessRatio: 0.9,
    trailOpacity: 0.7,
    enableGlow: false,
    glowIntensity: 0,
    animationCurve: Curves.fastOutSlowIn,
    particleShape: ParticleShape.circle,
    enableGradient: false,
  );

  /// Configuration prédéfinie pour un effet "étoile filante"
  static const ParticleTrailConfig shootingStar = ParticleTrailConfig(
    enableTrails: true,
    trailLength: 12,
    trailThicknessRatio: 0.6,
    trailOpacity: 0.5,
    enableGlow: false,
    glowIntensity: 0,
    animationCurve: Curves.easeInOutCubic,
    particleShape: ParticleShape.diamond,
    enableGradient: false,
  );

  /// Configuration prédéfinie pour un effet "minimal"
  static const ParticleTrailConfig minimal = ParticleTrailConfig(
    enableTrails: false,
    trailLength: 0,
    trailThicknessRatio: 0,
    trailOpacity: 0,
    enableGlow: false,
    glowIntensity: 0,
    animationCurve: Curves.easeOut,
    particleShape: ParticleShape.circle,
    enableGradient: false,
  );
}

/// Formes disponibles pour les particules
enum ParticleShape { circle, star, diamond, hexagon, triangle }
