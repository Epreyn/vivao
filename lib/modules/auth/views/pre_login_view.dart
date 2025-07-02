import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/custom_elevated_button.dart';
import '../controllers/pre_login_controller.dart';

class PreLoginView extends GetView<PreLoginController> {
  const PreLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            CustomElevatedButton(
              text: controller.loginButtonText,
              width: 180,
              height: 180,
            ),
          ],
        ),
      ),
    );
  }
}
