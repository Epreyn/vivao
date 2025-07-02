import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/custom_text_form_field_controller.dart';

class CustomTextFormField extends StatelessWidget {
  final String? tag;

  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;

  final TextEditingController? controller;

  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  final String? labelText;
  final String? hintText;
  final String? errorText;

  final IconData? iconData;
  final bool? isPassword;

  final String? validatorPattern;
  final String? Function(String?)? validator;

  final bool? isEnabled;
  final bool? isClickable;

  final int? minLines;
  final int? maxLines;
  final int? maxCharacters;

  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    this.tag,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.controller,
    this.textInputAction,
    this.labelText,
    this.hintText,
    this.errorText,
    this.iconData,
    this.isPassword,
    this.keyboardType,
    this.validatorPattern,
    this.validator,
    this.isEnabled = true,
    this.isClickable = true,
    this.minLines,
    this.maxLines = 1,
    this.maxCharacters,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final CustomTextFormFieldController cc = Get.put(
      CustomTextFormFieldController(
        controller: controller,
        maxCharacters: maxCharacters,
        isPassword: isPassword,
      ),
      tag: tag,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? 0.0,
        maxWidth: maxWidth ?? double.infinity,
        minHeight: minHeight ?? 0.0,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: Stack(
        children: [
          Obx(
            () => TextFormField(
              textInputAction: textInputAction ?? TextInputAction.done,
              keyboardType: keyboardType ?? TextInputType.text,
              controller: controller,
              enabled: isEnabled,
              obscureText: cc.isObscure.value,
              minLines: minLines ?? 1,
              maxLines: cc.isObscure.value ? 1 : (maxLines ?? 1),
              inputFormatters: cc.inputFormatters,
              onChanged: (value) {
                cc.currentLength.value = value.length;
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
              onFieldSubmitted: onFieldSubmitted,
              validator: (value) {
                if (validator != null) {
                  return validator!(value);
                } else if (validatorPattern != null) {
                  if (value == null || value.isEmpty) {
                    return errorText ?? "Ce champ est vide";
                  } else if (!RegExp(validatorPattern!).hasMatch(value)) {
                    return errorText ?? "Ce champ est invalide";
                  }
                } else {
                  if (value == null || value.isEmpty) {
                    return errorText ?? "Ce champ est vide";
                  }
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: maxCharacters == null
                    ? labelText
                    : "$labelText (${cc.currentLength.value}/$maxCharacters)",
                hintText: hintText,
                prefixIcon: iconData != null ? Icon(iconData) : null,
                suffixIcon: (isPassword ?? false)
                    ? MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: cc.togglePasswordVisibility,
                          child: Icon(
                            cc.isObscure.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      )
                    : null,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          if (!(isClickable ?? true))
            Positioned.fill(
              child: Material(color: Colors.transparent, child: Container()),
            ),
        ],
      ),
    );
  }
}
