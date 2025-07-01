import 'package:get/get.dart';
import '../controllers/pre_login_controller.dart';

class PreLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreLoginController>(() => PreLoginController());
  }
}
