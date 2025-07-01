import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Connexion', style: AppTextStyles.headline1),
              const SizedBox(height: 8),
              Text(
                'Connectez-vous pour continuer',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 32),

              // Email
              CustomTextFormField(
                controller: controller.emailController,
                labelText: 'Email',
                hintText: 'example@email.com',
                iconData: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Mot de passe
              CustomTextFormField(
                controller: controller.passwordController,
                labelText: 'Mot de passe',
                hintText: '********',
                iconData: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => controller.login(),
              ),
              const SizedBox(height: 24),

              // Bouton connexion
              Obx(
                () => CustomElevatedButton(
                  text: 'Se connecter',
                  onPressed: controller.login,
                  isLoading: controller.isLoading.value,
                ),
              ),
              const SizedBox(height: 24),

              // Lien vers inscription
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pas encore de compte? ',
                    style: AppTextStyles.bodyMedium,
                  ),
                  GestureDetector(
                    onTap: controller.navigateToRegister,
                    child: Text(
                      'Créer un compte',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
