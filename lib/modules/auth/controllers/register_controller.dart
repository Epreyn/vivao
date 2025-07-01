import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/controllers/base_controller.dart';
import '../../../core/routes/app_routes.dart';

class RegisterController extends BaseController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool isConsumer = true.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleUserType(bool value) {
    isConsumer.value = value;
  }

  Future<void> register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez remplir tous les champs',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Erreur',
        'Les mots de passe ne correspondent pas',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setLoading(true);

    // Simulation d'un appel API
    await Future.delayed(const Duration(seconds: 2));

    setLoading(false);

    // Navigation vers Home
    Get.offAllNamed(AppRoutes.home);
  }

  void navigateToLogin() {
    Get.back();
  }
}
