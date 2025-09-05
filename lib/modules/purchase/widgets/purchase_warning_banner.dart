import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget PurchaseWaringBanner() {
  return Container(
  // padding: EdgeInsets.all(12.w),
    padding: EdgeInsets.symmetric(vertical: 6.r, horizontal: 16.r),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.AE01),
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Text(
      "Lorem ipsum dolor sit amet, consectetur a adipiscing...",
      //style: TextStyle(color: AppColors.primary01, fontWeight: FontWeight.w500),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTypography.s14.regular.withColor(AppColors.AE01),
    ),
  );
}