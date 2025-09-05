import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/home_pickup_zone_controller.dart';
import '../controllers/location_search_controller.dart';
import '../views/location_search_view.dart';

class SearchFieldWidget extends GetView<HomePickupZoneController> {
  const SearchFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openSearchPage,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutral05),
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.neutral04, size: 20.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                LocaleKeys.search_address.trans(),
                style: AppTypography.s14.regular.withColor(AppColors.neutral04),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openSearchPage() async {
    // Đăng ký controller nếu chưa có
    if (!Get.isRegistered<LocationSearchController>()) {
      Get.put(LocationSearchController());
    }
    
    final result = await Get.to(() => LocationSearchView());
    if (result != null) {
      controller.handleSearchResult(result);
    }
  }
}