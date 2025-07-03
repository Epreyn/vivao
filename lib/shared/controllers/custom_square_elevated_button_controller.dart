// lib/shared/controllers/custom_square_elevated_button_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'particle_animation_controller.dart';

class CustomSquareElevatedButtonController extends GetxController {
  final RxBool isPressed = false.obs;
  final RxBool isHovered = false.obs;
  final RxBool isNavigating = false.obs;

  // Animation controller pour des animations plus complexes si besoin
  final RxDouble animationScale = 1.0.obs;

  // Controller pour les particules
  late ParticleAnimationController particleController;

  // Position du bouton pour l'animation des particules
  Offset? buttonCenter;

  // Durées d'animation configurables
  final Duration pressAnimationDuration;
  final Duration releaseAnimationDuration;
  final Duration navigationDelay;
  final double pressedScale;

  // Couleurs des particules (optionnel)
  final List<Color>? particleColors;

  CustomSquareElevatedButtonController({
    this.pressAnimationDuration = const Duration(milliseconds: 100),
    this.releaseAnimationDuration = const Duration(milliseconds: 150),
    this.navigationDelay = const Duration(milliseconds: 500),
    this.pressedScale = 0.94,
    this.particleColors,
  });

  @override
  void onInit() {
    super.onInit();

    // Initialiser le controller de particules
    particleController = Get.put(
      ParticleAnimationController(
        groupCount: 12, // Nombre optimal de particules
        particlesPerGroup: 1,
        sparkleSize: 3.5,
        animationDuration: const Duration(milliseconds: 600),
        particleColors: particleColors ?? [],
        spreadDistance: 30,
        trailLength: 4, // Trails courts pour la performance
      ),
      tag: '${hashCode}_particles',
    );

    // Observer les changements d'état pour mettre à jour l'échelle
    ever(isPressed, (bool pressed) {
      animationScale.value = pressed ? pressedScale : 1.0;
    });
  }

  void setButtonCenter(Offset center) {
    buttonCenter = center;
  }

  void onTapDown() {
    if (!isPressed.value && !isNavigating.value) {
      isPressed.value = true;
    }
  }

  void onTapUp(VoidCallback? onPressed, BuildContext context) {
    if (isPressed.value && !isNavigating.value) {
      isPressed.value = false;

      // Calculer le centre et la taille du bouton
      if (buttonCenter == null && context.mounted) {
        final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final size = renderBox.size;
          buttonCenter = Offset(size.width / 2, size.height / 2);

          // Déclencher l'animation de particules avec la taille du bouton
          particleController.triggerAnimation(
            center: buttonCenter!,
            size: size,
            customColors: particleColors,
          );
        }
      } else if (buttonCenter != null) {
        // Si on a déjà le centre, utiliser une taille par défaut
        final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
        final size = renderBox?.size ?? const Size(120, 120);
        particleController.triggerAnimation(
          center: buttonCenter!,
          size: size,
          customColors: particleColors,
        );
      }

      // Marquer comme en navigation
      isNavigating.value = true;

      // Attendre un peu avant de déclencher l'action
      if (onPressed != null) {
        Future.delayed(navigationDelay, () {
          onPressed();
          // Réinitialiser l'état après navigation
          Future.delayed(const Duration(milliseconds: 500), () {
            isNavigating.value = false;
          });
        });
      }
    }
  }

  void onTapCancel() {
    if (isPressed.value) {
      isPressed.value = false;
    }
  }

  void onHover(bool hovering) {
    isHovered.value = hovering;
  }

  // Méthode pour forcer la réinitialisation de l'état
  void reset() {
    isPressed.value = false;
    isHovered.value = false;
    isNavigating.value = false;
    animationScale.value = 1.0;
  }

  @override
  void onClose() {
    reset();
    // Nettoyer le controller de particules
    Get.delete<ParticleAnimationController>(tag: '${hashCode}_particles');
    super.onClose();
  }
}
