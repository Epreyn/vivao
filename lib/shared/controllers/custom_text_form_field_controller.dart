import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextFormFieldController extends GetxController {
  final TextEditingController? controller;
  final int? maxCharacters;
  final bool? isPassword;

  CustomTextFormFieldController({
    this.controller,
    this.maxCharacters,
    this.isPassword,
  });

  late final RxBool isObscure = (isPassword ?? false).obs;
  final RxInt currentLength = 0.obs;
  final List<TextInputFormatter> inputFormatters = [];

  @override
  void onInit() {
    super.onInit();
    maxCharactersListener();
    if (controller != null) {
      currentLength.value = controller!.text.length;
    }
  }

  void maxCharactersListener() {
    if (maxCharacters != null) {
      inputFormatters.add(LengthLimitingTextInputFormatter(maxCharacters));
    }
  }

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }
}
