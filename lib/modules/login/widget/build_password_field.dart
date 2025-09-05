import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

Widget buildOtpField() {
  final controller = Get.find<LoginController>();

  return Obx(
        () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller.otpController,
          keyboardType: TextInputType.number,
          onChanged: (_) {
            if (controller.otpError.value.isNotEmpty) {
              controller.otpError.value = '';
            }
          },
          decoration: InputDecoration(
            labelText: LocaleKeys.get_otp.trans(),
            // ✅ Màu viền động theo lỗi
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: controller.otpError.value.isNotEmpty
                    ? AppColors.primary01
                    : AppColors.neutral01,
                width: 1.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: controller.otpError.value.isNotEmpty
                    ? AppColors.primary01
                    : AppColors.neutral01,
                width: 1.w,
              ),
            ),
            // ✅ Suffix: Gửi lại mã / Đang gửi / Nhận mã
            suffixIcon: controller.resendSeconds.value > 0
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
               LocaleKeys.resend_code_later.trans()+ '  ${controller.resendSeconds.value}s',
                style: AppTypography.s12.regular
                    .withColor(AppColors.primary01),
              ),
            )
                : controller.isSendingOtp.value
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
                : TextButton(
              onPressed: controller.sendOtp,
              child: Text(
                LocaleKeys.get_otp.trans(),
                style: AppTypography.s12.regular
                    .withColor(AppColors.neutral03),
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),

        // ✅ Hiển thị lỗi nếu có
        if (controller.otpError.value.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              controller.otpError.value,
              style: AppTypography.s12.regular.copyWith(color: AppColors.primary01),
            ),
          ),
      ],
    ),
  );
}
