// lib/modules/auth/views/pre_login_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/custom_square_elevated_button.dart';
import '../controllers/pre_login_controller.dart';

class PreLoginView extends GetView<PreLoginController> {
  const PreLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1),

              // Logo et titre
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.local_grocery_store,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      controller.welcomeTitle,
                      style: AppTextStyles.headline1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.welcomeSubtitle,
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Titre de la section
              Text(
                'Comment souhaitez-vous commencer?',
                style: AppTextStyles.headline2,
              ),
              const SizedBox(height: 24),

              // Grille de boutons
              SizedBox(
                height: 160, // Hauteur fixe pour les boutons carrés
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSquareElevatedButton(
                        iconData: Icons.login,
                        text: controller.loginButtonText,
                        subText: 'Déjà membre',
                        onPressed: controller.navigateToLogin,
                        size: 160, // Boutons plus grands
                        backgroundColor: AppColors.primary,
                        particleColors: [
                          AppColors.primary,
                          Colors.cyan.shade300,
                          Colors.tealAccent,
                        ], // Couleurs personnalisées
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomSquareElevatedButton(
                        iconData: Icons.person_add,
                        text: controller.registerButtonText,
                        subText: 'Nouveau',
                        onPressed: controller.navigateToRegister,
                        size: 160,
                        backgroundColor: AppColors.secondary,
                        particleColors: [
                          Colors.purple,
                          Colors.deepPurple,
                          Colors.indigo,
                          Colors.blue,
                          Colors.pink,
                        ], // Couleurs personnalisées
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Ligne de séparation avec "ou"
              Row(
                children: [
                  Expanded(
                    child: Container(height: 1, color: Colors.grey.shade300),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      controller.orText,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                  Expanded(
                    child: Container(height: 1, color: Colors.grey.shade300),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Boutons sociaux
              SizedBox(
                height: 160, // Hauteur fixe pour les boutons carrés
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSquareElevatedButtonWithImage(
                        image: const Icon(
                          Icons
                              .g_mobiledata, // Remplacer par Image.asset('assets/images/google.png')
                          size: 24,
                          color: Colors.red,
                        ),
                        text: 'Google',
                        subText: 'avec',
                        onPressed: () {
                          Get.snackbar(
                            'Info',
                            'Connexion Google bientôt disponible',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        size: 160,
                        backgroundColor: Colors.white,
                        textColor: AppColors.textPrimary,
                        particleColors: [], // Effet arc-en-ciel automatique
                        shadow: BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomSquareElevatedButtonWithImage(
                        image: const Icon(
                          Icons.facebook,
                          size: 24,
                          color: Color(0xFF1877F2),
                        ),
                        text: 'Facebook',
                        subText: 'avec',
                        onPressed: () {
                          Get.snackbar(
                            'Info',
                            'Connexion Facebook bientôt disponible',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        size: 160,
                        backgroundColor: Colors.white,
                        textColor: AppColors.textPrimary,
                        particleColors: [], // Effet arc-en-ciel automatique
                        shadow: BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // Footer
              Center(
                child: Text(
                  'En continuant, vous acceptez nos conditions d\'utilisation',
                  style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
