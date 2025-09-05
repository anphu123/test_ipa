import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

Widget buildRegisterButton() {
  final controller = Get.find<RegisterController>();
  return Obx(
    () => SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed:
            controller.isLoading.value
                ? null
                : () {
                  controller.register();
                },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellowFidoBox,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child:
            controller.isLoading.value
                ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                : Text(
                  LocaleKeys.register.trans(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
      ),
    ),
  );
}
