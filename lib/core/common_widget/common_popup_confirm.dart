import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';
import 'common_button_app.dart';

class CommonPopupConfirm extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;
  const CommonPopupConfirm({super.key, required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 5.h),
            Icon(
              Icons.info,
              size: 60.sp,
              color: AppColors.yellowFEA400,
            ),
            SizedBox(height: 10.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.black),
            ),
            SizedBox(height: 25.h),
            Row(
              children: [
                Expanded(
                  child: CommonButtonApp(
                    //buttonText: LocaleKeys.close.trans(),
                    buttonText: 'Đóng',
                    bgColor: AppColors.white,
                    textColor: AppColors.primary,
                    onPressed: Get.back,
                    height: 45.h,
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: CommonButtonApp(
                    //buttonText: LocaleKeys.ok.trans(),
                    buttonText: "Ok",
                    bgColor: AppColors.primary,
                    textColor: AppColors.white,
                    onPressed: onConfirm,
                    height: 45.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
