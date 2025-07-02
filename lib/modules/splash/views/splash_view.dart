import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Forcer l'initialisation du controller
    final controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou icône de l'application
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.local_grocery_store,
                size: 60,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),

            // Nom de l'application
            Text(
              'Vivao',
              style: AppTextStyles.headline1.copyWith(
                color: Colors.white,
                fontSize: 48,
              ),
            ),
            const SizedBox(height: 8),

            // Slogan
            Text(
              'Du producteur à votre table',
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 48),

            // Indicateur de chargement
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
