import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

Widget buildPasswordFieldR() {
  final controller = Get.find<RegisterController>();
  return Obx(
        () => TextField(
      controller: controller.passwordController,
      obscureText: controller.isPasswordHidden.value,
      decoration: InputDecoration(
        labelText: LocaleKeys.password.trans(),
        hintText: LocaleKeys.enter_password.trans(),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(controller.isPasswordHidden.value
              ? Icons.visibility_off
              : Icons.visibility),
          onPressed: controller.togglePasswordVisibility,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.yellowFidoBoxText, width: 2),
        ),
        errorText: controller.passwordError.value.isEmpty
            ? null
            : controller.passwordError.value,
      ),
      onChanged: controller.validatePassword,
    ),
  );
}
