// lib/modules/auth/controllers/pre_login_controller.dart

import 'package:get/get.dart';
import '../../../shared/controllers/base_controller.dart';
import '../../../core/routes/app_routes.dart';

class PreLoginController extends BaseController {
  // Constantes pour les textes
  final String welcomeTitle = 'Bienvenue sur Vivao';
  final String welcomeSubtitle =
      'Connectez les producteurs locaux avec les consommateurs';
  final String loginButtonText = 'Se connecter';
  final String registerButtonText = 'Créer un compte';
  final String orText = 'ou';

  void navigateToLogin() {
    Get.toNamed(AppRoutes.login);
  }

  void navigateToRegister() {
    Get.toNamed(AppRoutes.register);
  }
}
