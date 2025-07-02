import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_pages.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vivao',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.initial,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      // Ajout de configurations supplémentaires
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
      // Pour le débogage
      enableLog: true,
      logWriterCallback: (String text, {bool isError = false}) {
        print('GetX Log: $text');
      },
      // Gestion des routes non trouvées
      unknownRoute: GetPage(
        name: '/notfound',
        page: () =>
            const Scaffold(body: Center(child: Text('Route not found!'))),
      ),
    );
  }
}
