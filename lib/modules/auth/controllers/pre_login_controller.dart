import 'package:get/get.dart';
import '../../../shared/controllers/base_controller.dart';
import '../../../core/routes/app_routes.dart';

class PreLoginController extends BaseController {
  // Variables pour gérer l'état des boutons
  RxBool isLoginButtonLoading = false.obs;
  RxBool isRegisterButtonLoading = false.obs;

  // Constantes pour les textes
  final String welcomeTitle = 'Bienvenue sur Vivao';
  final String welcomeSubtitle =
      'Connectez les producteurs locaux avec les consommateurs';
  final String loginButtonText = 'Se connecter';
  final String registerButtonText = 'Créer un compte';
  final String orText = 'ou';

  void navigateToLogin() async {
    isLoginButtonLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    Get.toNamed(AppRoutes.login);
    isLoginButtonLoading.value = false;
  }

  void navigateToRegister() async {
    isRegisterButtonLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    Get.toNamed(AppRoutes.register);
    isRegisterButtonLoading.value = false;
  }
}
