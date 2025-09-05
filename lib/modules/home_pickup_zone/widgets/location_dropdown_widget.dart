import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/home_pickup_zone_controller.dart';

// i18n
import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

class LocationDropdownWidget extends GetView<HomePickupZoneController> {
  const LocationDropdownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showLocationBottomSheet,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutral04),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Text(
              controller.selectedLocation.value,
              style: AppTypography.s14.regular.withColor(AppColors.neutral02),
            )),
            SizedBox(width: 8.w),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20.sp,
              color: AppColors.neutral02,
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationBottomSheet() {
    final allLabel = LocaleKeys.all_locations.trans();
    final defaultLabel = LocaleKeys.location_default_label.trans();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.select_location_title.trans(),
              style: AppTypography.s16.bold.withColor(AppColors.neutral01),
            ),
            SizedBox(height: 20.h),

            // TẤT CẢ ĐỊA ĐIỂM
            Obx(() => ListTile(
              title: Text(allLabel),
              trailing: (controller.selectedLocation.value == defaultLabel)
                  ? Icon(Icons.check, color: AppColors.primary01)
                  : null,
              onTap: () {
                controller.changeLocation(defaultLabel);
                Get.back();
              },
            )),

            // Danh sách khu vực (zones)
            Obx(() => Column(
              children: controller.pickupZones
                  .map(
                    (zone) => ListTile(
                  title: Text(zone.name),
                  trailing: controller.selectedLocation.value == zone.name
                      ? Icon(Icons.check, color: AppColors.primary01)
                      : null,
                  onTap: () {
                    controller.changeLocation(zone.name);
                    Get.back();
                  },
                ),
              )
                  .toList(),
            )),
          ],
        ),
      ),
    );
  }
}
