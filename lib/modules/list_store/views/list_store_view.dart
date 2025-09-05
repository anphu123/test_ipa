import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/list_store_controller.dart';
import '../widgets/store_card.dart';

// i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

class ListStoreView extends GetView<ListStoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.neutral01),
          onPressed: () => Get.back(),
        ),
        title: Text(
          LocaleKeys.list_store_title.trans(),
          style: AppTypography.s20.medium.copyWith(color: AppColors.neutral01),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildStoreList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.list_store_enable_location_hint.trans(),
            style: AppTypography.s14.semibold.copyWith(color: AppColors.neutral03),
          ),
          SizedBox(height: 12.h),
          Obx(() => _buildLocationDropdown()),
        ],
      ),
    );
  }

  Widget _buildLocationDropdown() {
    return GestureDetector(
      onTap: () => controller.getCurrentLocation(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutral06),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on, size: 16.sp, color: AppColors.primary01),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                controller.selectedLocation.value,
                style: AppTypography.s14.regular.copyWith(color: AppColors.neutral01),
              ),
            ),
            Icon(Icons.refresh, size: 20.sp, color: AppColors.neutral03),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: controller.filteredStores.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final store = controller.filteredStores[index];
          return StoreCard(store: store);
        },
      );
    });
  }
}
