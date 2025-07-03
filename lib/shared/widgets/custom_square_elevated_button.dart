// lib/shared/widgets/custom_square_elevated_button.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_dimensions.dart';
import '../controllers/custom_square_elevated_button_controller.dart';
import 'particle_animation_widget.dart';

class CustomSquareElevatedButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final String? subText;
  final VoidCallback? onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final Color? subTextColor;
  final Color? splashColor;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final BoxShadow? shadow;
  final List<Color>? particleColors;

  const CustomSquareElevatedButton({
    super.key,
    required this.iconData,
    required this.text,
    this.subText,
    this.onPressed,
    this.size = 120,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.subTextColor,
    this.splashColor,
    this.iconSize,
    this.padding,
    this.borderRadius,
    this.shadow,
    this.particleColors,
  });

  @override
  Widget build(BuildContext context) {
    // Créer un controller unique pour chaque bouton
    final String tag =
        '${iconData.hashCode}_${text.hashCode}_${UniqueKey().hashCode}';
    final controller = Get.put(
      CustomSquareElevatedButtonController(
        particleColors:
            particleColors ??
            [backgroundColor ?? AppColors.primary, Colors.white],
      ),
      tag: tag,
    );

    return Center(
      child: AspectRatio(
        aspectRatio: 1, // Force le ratio 1:1 pour un carré parfait
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size, maxHeight: size),
          child: ParticleAnimationWidget(
            controller: controller.particleController,
            child: Obx(
              () => AnimatedScale(
                scale: controller.animationScale.value,
                duration: controller.isPressed.value
                    ? controller.pressAnimationDuration
                    : controller.releaseAnimationDuration,
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  opacity: controller.isNavigating.value ? 0.6 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? AppDimensions.radiusMedium,
                      ),
                      boxShadow: [
                        shadow ??
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                controller.isPressed.value ? 0.15 : 0.1,
                              ),
                              blurRadius: controller.isPressed.value ? 12 : 8,
                              offset: Offset(
                                0,
                                controller.isPressed.value ? 6 : 4,
                              ),
                            ),
                      ],
                    ),
                    child: Material(
                      color: backgroundColor ?? AppColors.primary,
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? AppDimensions.radiusMedium,
                      ),
                      child: InkWell(
                        onTapDown:
                            onPressed == null || controller.isNavigating.value
                            ? null
                            : (_) => controller.onTapDown(),
                        onTapUp:
                            onPressed == null || controller.isNavigating.value
                            ? null
                            : (_) => controller.onTapUp(onPressed, context),
                        onTapCancel: onPressed == null
                            ? null
                            : () => controller.onTapCancel(),
                        onHover: (hovering) => controller.onHover(hovering),
                        splashColor:
                            splashColor ?? Colors.white.withOpacity(0.3),
                        highlightColor: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          borderRadius ?? AppDimensions.radiusMedium,
                        ),
                        child: Container(
                          padding:
                              padding ??
                              const EdgeInsets.all(AppDimensions.paddingMedium),
                          child: Stack(
                            children: [
                              // Icône en haut à gauche
                              Positioned(
                                top: 0,
                                left: 0,
                                child: AnimatedOpacity(
                                  opacity: controller.isHovered.value
                                      ? 0.8
                                      : 1.0,
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    iconData,
                                    size: iconSize ?? AppDimensions.iconLarge,
                                    color: iconColor ?? Colors.white,
                                  ),
                                ),
                              ),
                              // Texte et sous-texte en bas à gauche
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (subText != null) ...[
                                      Text(
                                        subText!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color:
                                              subTextColor ??
                                              Colors.white.withOpacity(0.8),
                                          fontFamily: AppTextStyles.fontFamily,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                    ],
                                    Text(
                                      text,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: textColor ?? Colors.white,
                                        fontFamily: AppTextStyles.fontFamily,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Version avec image au lieu d'icône
class CustomSquareElevatedButtonWithImage extends StatelessWidget {
  final Widget image; // Peut être Image.asset, Image.network, etc.
  final String text;
  final String? subText;
  final VoidCallback? onPressed;
  final double size;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? subTextColor;
  final Color? splashColor;
  final double? imageSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final BoxShadow? shadow;
  final List<Color>? particleColors;

  const CustomSquareElevatedButtonWithImage({
    super.key,
    required this.image,
    required this.text,
    this.subText,
    this.onPressed,
    this.size = 120,
    this.backgroundColor,
    this.textColor,
    this.subTextColor,
    this.splashColor,
    this.imageSize,
    this.padding,
    this.borderRadius,
    this.shadow,
    this.particleColors,
  });

  @override
  Widget build(BuildContext context) {
    // Créer un controller unique pour chaque bouton
    final String tag =
        '${image.hashCode}_${text.hashCode}_${UniqueKey().hashCode}';
    final controller = Get.put(
      CustomSquareElevatedButtonController(
        particleColors:
            particleColors ??
            [AppColors.primary, backgroundColor ?? Colors.white],
      ),
      tag: tag,
    );

    return Center(
      child: AspectRatio(
        aspectRatio: 1, // Force le ratio 1:1 pour un carré parfait
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: size, maxHeight: size),
          child: ParticleAnimationWidget(
            controller: controller.particleController,
            child: Obx(
              () => AnimatedScale(
                scale: controller.animationScale.value,
                duration: controller.isPressed.value
                    ? controller.pressAnimationDuration
                    : controller.releaseAnimationDuration,
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  opacity: controller.isNavigating.value ? 0.6 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? AppDimensions.radiusMedium,
                      ),
                      boxShadow: [
                        shadow ??
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                controller.isPressed.value ? 0.15 : 0.08,
                              ),
                              blurRadius: controller.isPressed.value ? 6 : 4,
                              offset: Offset(
                                0,
                                controller.isPressed.value ? 3 : 2,
                              ),
                            ),
                      ],
                    ),
                    child: Material(
                      color: backgroundColor ?? AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? AppDimensions.radiusMedium,
                      ),
                      child: InkWell(
                        onTapDown:
                            onPressed == null || controller.isNavigating.value
                            ? null
                            : (_) => controller.onTapDown(),
                        onTapUp:
                            onPressed == null || controller.isNavigating.value
                            ? null
                            : (_) => controller.onTapUp(onPressed, context),
                        onTapCancel: onPressed == null
                            ? null
                            : () => controller.onTapCancel(),
                        onHover: (hovering) => controller.onHover(hovering),
                        splashColor:
                            splashColor ?? AppColors.primary.withOpacity(0.1),
                        highlightColor: AppColors.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(
                          borderRadius ?? AppDimensions.radiusMedium,
                        ),
                        child: Container(
                          padding:
                              padding ??
                              const EdgeInsets.all(AppDimensions.paddingMedium),
                          child: Stack(
                            children: [
                              // Image en haut à gauche
                              Positioned(
                                top: 0,
                                left: 0,
                                child: AnimatedOpacity(
                                  opacity: controller.isHovered.value
                                      ? 0.8
                                      : 1.0,
                                  duration: const Duration(milliseconds: 200),
                                  child: SizedBox(
                                    width: imageSize ?? 32,
                                    height: imageSize ?? 32,
                                    child: image,
                                  ),
                                ),
                              ),
                              // Texte et sous-texte en bas à gauche
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (subText != null) ...[
                                      Text(
                                        subText!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color:
                                              subTextColor ??
                                              AppColors.textSecondary,
                                          fontFamily: AppTextStyles.fontFamily,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                    ],
                                    Text(
                                      text,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            textColor ?? AppColors.textPrimary,
                                        fontFamily: AppTextStyles.fontFamily,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
