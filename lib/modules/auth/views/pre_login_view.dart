import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
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
            children: [
              const Spacer(),

              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.local_grocery_store,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),

              // Titre
              Text(
                controller.welcomeTitle,
                style: AppTextStyles.headline1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Sous-titre
              Text(
                controller.welcomeSubtitle,
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Bouton Se connecter
              Obx(
                () => CustomElevatedButton(
                  text: controller.loginButtonText,
                  onPressed: controller.navigateToLogin,
                  isLoading: controller.isLoginButtonLoading.value,
                  backgroundColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),

              // Texte "ou"
              Text(controller.orText, style: AppTextStyles.bodyMedium),
              const SizedBox(height: 16),

              // Bouton Créer un compte
              Obx(
                () => CustomElevatedButton(
                  text: controller.registerButtonText,
                  onPressed: controller.navigateToRegister,
                  isLoading: controller.isRegisterButtonLoading.value,
                  isOutlined: true,
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.primary,
                ),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
