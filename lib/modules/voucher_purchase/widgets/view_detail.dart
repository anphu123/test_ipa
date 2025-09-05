import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class VoucherDetailView extends StatelessWidget {
  const VoucherDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        elevation: 3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Xem chi tiết',
          style: AppTypography.s16.bold.withColor(AppColors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: ListView(
          children: List.generate(3, (index) {
            final number = index + 1;
            return Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$number. Lorem ipsum dolor sit amet",
                    style: AppTypography.s14.bold,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    loremText,
                    style: AppTypography.s13.regular,
                  ),
                ],
              ),
            );
          })
            ..add(Text(
              loremText,
              style: AppTypography.s13.regular,
            )),
        ),
      ),
    );
  }

  String get loremText =>
      "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. "
          "In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. "
          "Pulvinar vivamus fringilla lacus nec metus bibendum egestas. "
          "Laculis massa nisl malesuada lacinia integer nunc posuere. "
          "Ut hendrerit semper vel class aptent taciti sociosqu. "
          "Ad litora torquent per conubia nostra inceptos himenaeos.";
}
