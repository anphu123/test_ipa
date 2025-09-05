import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_home_controller.dart';

class PickupInfoWidget extends GetView<OrderPurchaseAtHomeController> {
  const PickupInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.neutral06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: AppColors.success,
                size: 20.r,
              ),
              SizedBox(width: 8.w),
              Text(
                LocaleKeys.pickup_arrival_time.trans(),
                style: AppTypography.s14.medium.copyWith(
                  color: AppColors.neutral01,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Obx(() => Text(
            controller.pickupDateTime,
            style: AppTypography.s14.regular.copyWith(
              color: AppColors.neutral02,
            ),
          )),
        ],
      ),
    );
  }
}
