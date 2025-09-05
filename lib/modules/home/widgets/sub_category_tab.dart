import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/home/widgets/sub_category_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';

class SubCategoryTab extends StatelessWidget {
  const SubCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    ImageProvider getImageProvider(String path) {
      if (path.startsWith('http') || path.startsWith('https')) {
        return NetworkImage(path);
      } else {
        return AssetImage(path);
      }
    }

    return Obx(() {
      if (controller.subCategories.isEmpty) return const SizedBox.shrink();
      if (controller.selectedCategoryId.value == 0) return SubCategoryAll();

      final subCategories = controller.subCategories;
      final showMore = subCategories.length > 3;

      final displayCount = 4;
      final items = List.generate(displayCount, (index) {
        if (showMore && index == 3) {
          return _buildMoreButton();
        }

        if (index >= subCategories.length) {
          return const SizedBox();
        }

        final subCategory = subCategories[index];
        final isSelected =
            controller.selectedSubCategoryId.value == subCategory.id;

        return _buildSubCategoryItem(
          imageUrl: subCategory.imgUrl ?? '',
          isSelected: isSelected,
          onTap: () => controller.selectSubCategory(subCategory.id),
        );
      });

      return Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return Column(
                    children: [
                      Image.asset(
                        Assets.images.logosGoogle.path,
                        width: 40.w, // Adjust the width as needed
                        height: 40.w, // Adjust the height as needed
                      ),
                      SizedBox(height: 4.h),
                      // Add some space between image and text
                      Text(
                        "Item ${index + 1}",
                        style: AppTypography.s12.semibold.withColor(
                          AppColors.neutral01,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return Column(
                    children: [
                      Image.asset(
                        Assets.images.logosGoogle.path,
                        width: 40.w, // Adjust the width as needed
                        height: 40.w, // Adjust the height as needed
                      ),
                      SizedBox(height: 4.h),
                      // Add some space between image and text
                      Text(
                        "Item ${index + 1}",
                        style: AppTypography.s12.semibold.withColor(
                          AppColors.neutral01,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 46.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSubCategoryItem({
    required String imageUrl,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (1.sw - 32.w - 12.w * 3) / 4,
        // chia đều 4 ô với padding + spacing
        height: 36.h,
        decoration: BoxDecoration(
          color: AppColors.neutral07,
          borderRadius: BorderRadius.circular(8.r),
          border:
              isSelected
                  ? Border.all(color: AppColors.primary01, width: 1.2)
                  : null,
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Center(
          child: Image(
            image:
                imageUrl.startsWith('http')
                    ? NetworkImage(imageUrl)
                    : AssetImage(imageUrl) as ImageProvider,
            // width: 20.w,
            // height: 20.w,
            fit: BoxFit.cover,
            errorBuilder:
                (_, __, ___) => Icon(Icons.image_not_supported, size: 20.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildMoreButton() {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          LocaleKeys.notification.trans(),
          LocaleKeys.feature_not_implemented.trans(),
          duration: const Duration(milliseconds: 2000),
        );
      },
      child: Container(
       width: (1.sw - 32.w - 12.w * 3) / 4, // same width as others
        height: 36.h,
        decoration: BoxDecoration(
          color: AppColors.neutral07,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
             LocaleKeys.view_more.trans(),
              style: AppTypography.s10.medium.copyWith(color: AppColors.neutral01),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.arrow_forward, size: 14.sp, color: AppColors.neutral01),
          ],
        ),
      ),
    );
  }
}
