import 'package:get/get.dart';
import '../../../shared/controllers/base_controller.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    _navigateToPreLogin();
  }

  void _navigateToPreLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed('/pre-login');
  }
}
