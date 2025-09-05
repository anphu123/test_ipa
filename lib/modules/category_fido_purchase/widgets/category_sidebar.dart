import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/category_fido_purchase_controller.dart';

class CategorySidebar extends StatelessWidget {
  final CategoryFidoPurchaseController controller;

  const CategorySidebar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      color: AppColors.neutral08,
      child: ListView.builder(
        controller: controller.scrollController,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          return Obx(() => _buildSidebarItem(index));
        },
      ),
    );
  }

  Widget _buildSidebarItem(int index) {
    final isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () {
        controller.selectedIndex.value = index;
        controller.scrollController.animateTo(
          index * 60.h,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        color: isSelected ? Colors.white : Colors.transparent,
        child: Row(
          children: [
            if (isSelected)
              Container(width: 4.w, height: 30.h, color: AppColors.primary01),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                controller.categories[index],
                style: AppTypography.s14
                    .withFontWeight(isSelected ? FontWeight.bold : FontWeight.normal)
                    .withColor(AppColors.neutral01),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
