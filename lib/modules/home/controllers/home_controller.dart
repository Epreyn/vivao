import 'package:get/get.dart';
import '../../../shared/controllers/base_controller.dart';

class HomeController extends BaseController {
  RxString userName = 'Utilisateur'.obs;
  RxList<String> categories = <String>[
    'Légumes',
    'Fruits',
    'Produits laitiers',
    'Viandes',
    'Œufs',
    'Miel',
  ].obs;

  RxInt selectedCategoryIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    setLoading(true);
    // Simulation du chargement des données
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void logout() {
    Get.offAllNamed('/pre-login');
  }
}
