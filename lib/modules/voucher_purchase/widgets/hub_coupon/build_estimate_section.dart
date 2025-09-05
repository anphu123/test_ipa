import 'package:fido_box_demo01/core/common_widget/currency_util.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget BuildEstimateSection() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black.withOpacity(0.08),
      //     blurRadius: 6,
      //     offset: Offset(0, 2),
      //   ),
      // ],
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ước tính giá",
                  style: AppTypography.s16.semibold.withColor(
                    AppColors.neutral01,
                  ),
                ),
                Text(
                  "Sau khi áp dụng voucher",
                  style: AppTypography.s10.regular.withColor(
                    AppColors.neutral03,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.primary01,
                borderRadius: BorderRadius.circular(8.r),
              ),
              //  child: Image.asset(Assets.images.icVoucherTask.path,fit: BoxFit.fill,),
              child: Center(
                child: Text(
                  "Xem ngay",
                  style: AppTypography.s16.regular.withColor(AppColors.white),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          //  padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Xiaomi 15 Ultra",
                style: AppTypography.s14.regular.withColor(AppColors.neutral01),
              ),
              SizedBox(height: 4.h),
              Text(
                formatCurrency(35000000),
                style: AppTypography.s16.bold.withColor(AppColors.primary01),
              ),
              SizedBox(height: 4.h),
              RichText(
                text: TextSpan(
                  style: AppTypography.s12.regular.withColor(
                    AppColors.neutral01,
                  ),
                  children: [
                    const TextSpan(text: "Ước tính cơ bản "),
                    TextSpan(
                      text: formatCurrency(34000000),
                      style: AppTypography.s12.semibold.withColor(
                        AppColors.neutral01,
                      ),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Icon(Icons.add, size: 14.sp, color: Colors.grey),
                      ),
                    ),
                     TextSpan(text: "  Phiếu tặng giá "),
                    TextSpan(
                      text: formatCurrency(1000000),
                      style: AppTypography.s12.bold.withColor(
                        AppColors.neutral01,
                      ),
                    ),
                  ],
                ),
              ),
              // giá ước tính + phiếu tặng
            ],
          ),
        ),
      ],
    ),
  );
}
