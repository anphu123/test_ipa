import 'package:fido_box_demo01/modules/favourite/widgets/follow/popular_group.dart';
import 'package:fido_box_demo01/modules/favourite/widgets/follow/product_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common_widget/currency_util.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/followed_tab_controller.dart';
import '../../domain/favourite_product_model.dart';

class FollowedTab extends StatelessWidget {
  final FollowedTabController controller = Get.put(FollowedTabController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubFilter(),
            ...controller.categoryList
                .map((category) => buildProductGroup(category))
                .toList(),
            SizedBox(height: 16.h),
            Column(
              children: [
                Center(
                  child: Text(
                    "LỰA CHỌN PHỔ BIẾN",
                    style: AppTypography.s16.bold.withColor(
                      AppColors.neutral01,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                buildPopularGroup(),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSubFilter() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          _buildFilterChip("Thương hiệu"),
          SizedBox(width: 8.w),
          _buildFilterChip("Dòng sản phẩm"),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.neutral05,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: AppTypography.s16.regular.withColor(AppColors.neutral01),
      ),
    );
  }
}
