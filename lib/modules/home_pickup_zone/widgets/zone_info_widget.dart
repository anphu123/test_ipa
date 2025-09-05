import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/home_pickup_zone_controller.dart';
import 'pickup_rules.dart';

class ZoneInfoWidget extends GetView<HomePickupZoneController> {
  const ZoneInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20.h,
      left: 20.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.home_collection_area.trans(),
              style: AppTypography.s12.medium.copyWith(
                color: AppColors.primary01,
              ),
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () => PickupRules.show(),
              child: Text(
               LocaleKeys.rules.trans(),
                style: AppTypography.s10.regular.copyWith(
                  color: AppColors.neutral03,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



