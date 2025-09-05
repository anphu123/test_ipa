import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';

void showCvvDialog(BuildContext context) {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.verification_code.trans(),
            //  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              style: AppTypography.s20.bold.withColor(AppColors.neutral01),
            ),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.cvv_info.trans(),
              textAlign: TextAlign.center,
              style: AppTypography.s12.regular.withColor(AppColors.neutral03),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                Assets.images.showCvv.path, // 👉 hình ảnh như trong ảnh bạn gửi
                height: 160,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:AppColors.primary01,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Get.back(),
                child:  Text(LocaleKeys.agree.trans(),style: AppTypography.s16.regular.withColor(AppColors.white),),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}