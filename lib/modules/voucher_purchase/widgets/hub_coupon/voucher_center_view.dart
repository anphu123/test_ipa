import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/voucher_purchase/widgets/app_bar_voucher.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/assets.gen.dart';
import 'build_estimate_section.dart';

import 'build_voucher_task_section.dart';
import 'build_voucher_warehouse_section.dart';

class VoucherCenterView extends StatelessWidget {
  const VoucherCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      body: CustomScrollView(
        slivers: [
          AppBarVoucher(),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildVoucherWarehouseSection(),
                  SizedBox(height: 24.h),
                  BuildVoucherTaskSection(),
                  SizedBox(height: 24.h),
                  BuildEstimateSection(),
                  SizedBox(height: 24.h),
                  reportIssue(
                    onTap:
                        () => Get.snackbar(
                          LocaleKeys.notification.trans(),
                          LocaleKeys.feature_not_implemented.trans(),
                          snackPosition: SnackPosition.TOP,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget reportIssue({VoidCallback? onTap}) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit_note_outlined,
                size: 24.sp,
                color: AppColors.neutral04,
              ),
              SizedBox(width: 6.w),
              Text(
                "Gặp vấn đề?",
                style: AppTypography.s14.regular.withColor(AppColors.neutral04),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
