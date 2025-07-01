import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
              Text('Créer un compte', style: AppTextStyles.headline1),
              const SizedBox(height: 8),
              Text(
                'Rejoignez la communauté Vivao',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: 32),

              // Type d'utilisateur
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Je suis:',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text('Consommateur'),
                              value: true,
                              groupValue: controller.isConsumer.value,
                              onChanged: (value) =>
                                  controller.toggleUserType(value!),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              title: const Text('Producteur'),
                              value: false,
                              groupValue: controller.isConsumer.value,
                              onChanged: (value) =>
                                  controller.toggleUserType(value!),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Nom
              CustomTextFormField(
                controller: controller.nameController,
                labelText: 'Nom complet',
                hintText: 'John Doe',
                iconData: Icons.person_outline,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

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
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // Confirmer mot de passe
              CustomTextFormField(
                controller: controller.confirmPasswordController,
                labelText: 'Confirmer le mot de passe',
                hintText: '********',
                iconData: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => controller.register(),
              ),
              const SizedBox(height: 24),

              // Bouton inscription
              Obx(
                () => CustomElevatedButton(
                  text: 'Créer mon compte',
                  onPressed: controller.register,
                  isLoading: controller.isLoading.value,
                ),
              ),
              const SizedBox(height: 24),

              // Lien vers connexion
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Déjà un compte? ', style: AppTextStyles.bodyMedium),
                  GestureDetector(
                    onTap: controller.navigateToLogin,
                    child: Text(
                      'Se connecter',
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
