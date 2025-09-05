import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/login_controller.dart';

Widget buildLoginButton() {
  final controller = Get.find<LoginController>();
  return Obx(
    () => ElevatedButton(
      onPressed: controller.isLoading.value ? null : controller.loginWithOtp,

      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary01,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child:
          controller.isLoading.value
              ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              )
              : Text(
                LocaleKeys.login.trans(),
                style: AppTypography.s14.withColor(AppColors.white),
              ),
    ),
  );
}
