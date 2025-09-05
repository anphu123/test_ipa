import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

Widget buildConfirmPasswordField() {
  final controller = Get.find<RegisterController>();
  return Obx(
    () => TextField(
      controller: controller.confirmPasswordController,
      obscureText: controller.isConfirmPasswordHidden.value,
      decoration: InputDecoration(
        labelText: LocaleKeys.confirm_password.trans(),
        hintText: LocaleKeys.enter_confirm_password.trans(),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            controller.isConfirmPasswordHidden.value
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: controller.toggleConfirmPasswordVisibility,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.yellowFidoBoxText, width: 2),
        ),
        errorText:
            controller.confirmPasswordError.value.isEmpty
                ? null
                : controller.confirmPasswordError.value,
      ),
      onChanged: controller.validateConfirmPassword,
    ),
  );
}
