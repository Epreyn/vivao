import 'package:get/get.dart';
import '../../../shared/controllers/base_controller.dart';

class SplashController extends BaseController {
  @override
  void onReady() {
    super.onReady();
    // Utiliser onReady au lieu de onInit peut parfois résoudre les problèmes de timing
    _navigateToPreLogin();
  }

  void _navigateToPreLogin() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // Vérifier si la route existe
      if (Get.routing.route?.settings.name == '/') {
        // Option 1: Navigation avec offNamed
        await Get.offNamed('/pre-login');

        // Si ça ne marche pas, décommentez l'option 2:
        // Option 2: Navigation avec offAllNamed
        //await Get.offAllNamed('/pre-login');
      }
    } catch (e) {
      print('Navigation error: $e');
      // En cas d'erreur, forcer la navigation
      Get.offAllNamed('/pre-login');
    }
  }
}
