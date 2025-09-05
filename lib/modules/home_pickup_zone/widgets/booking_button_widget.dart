import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/home_pickup_zone_controller.dart';

class BookingButtonWidget extends GetView<HomePickupZoneController> {
  const BookingButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.transparent,
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: Obx(() {
          return ElevatedButton(
            onPressed: controller.isLoading.value 
                ? null 
                : controller.bookHomePickup,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary01,
              disabledBackgroundColor: AppColors.neutral05,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: controller.isLoading.value
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                 LocaleKeys.schedule_home_pickup.trans(),
                    style: AppTypography.s16.medium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
