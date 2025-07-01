import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/controllers/base_controller.dart';
import '../../../core/routes/app_routes.dart';

class LoginController extends BaseController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez remplir tous les champs',
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

  void navigateToRegister() {
    Get.toNamed(AppRoutes.register);
  }
}
