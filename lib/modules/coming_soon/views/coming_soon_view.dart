import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.neutral01),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            // Image.asset(
            //   Assets.images.logoNew.path,
            //   width: 120.w,
            //   height: 120.h,
            // ),
            // SizedBox(height: 40.h),

            Image.asset(Assets.images.comingSoon.path ),

            // Coming Soon Text
            // Text(
            //   "Sắp ra mắt",
            //   style: AppTypography.s24.bold.withColor(AppColors.primary01),
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 16.h),

            // Description
            // Text(
            //   "Tính năng này đang được phát triển\nvà sẽ sớm có mặt trong phiên bản tiếp theo",
            //   style: AppTypography.s16.regular.withColor(AppColors.neutral03),
            //   textAlign: TextAlign.center,
            // ),
            // SizedBox(height: 60.h),

            // Icon

          ],
        ),
      ),
    );
  }
}