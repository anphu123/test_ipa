import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VoucherItemDialog extends StatelessWidget {
  final String value;
  final String condition;
  final String? label;

  const VoucherItemDialog({
    super.key,
    required this.value,
    required this.condition,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        gradient: AppColors.secondaryGra01,

        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main container
          Container(
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Text(
                  value,
                  style: AppTypography.s24.bold.withColor(AppColors.primary01),
                ),
                SizedBox(width: 12.w),
                Container(
                  height: 28.h,
                  width: 1.5.w,
                  color: AppColors.primary03,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    condition,
                    style: AppTypography.s12.regular.withColor(
                      AppColors.primary01,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Top-left label
          if (label != null)
            Positioned(
              top: -8.h,
              left: -4.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.AW02,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                  border: Border.all(color: AppColors.AW01, width: 1.w),
                ),
                child: Text(
                  label!,
                  style: AppTypography.s10.regular.withColor(AppColors.AW01),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
