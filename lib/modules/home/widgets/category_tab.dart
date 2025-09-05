import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      decoration: BoxDecoration(color: Colors.white),

      child: SizedBox(
        height: 30.h,

        child: ListView.separated(
          controller: controller.categoryScrollController,
          // Gắn vào đây
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: controller.categories.length,
          separatorBuilder: (_, __) => SizedBox(width: 5.w),
          itemBuilder: (context, index) {
            final category = controller.categories[index];

            return Obx(() {
              final isSelected =
                  controller.selectedCategoryId.value == category.id;
              return InkWell(
                key: controller.categoryItemKeys[index], // Gắn key tại đây
                borderRadius: BorderRadius.circular(12.r),
                onTap: () {
                  print('Selected Category: ${category.name}');
                 // print(${controller.subCategories.value.})
                  controller.selectCategory(category.id);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? AppColors.primary01 : Colors.transparent,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      controller.getTranslatedSubCategoryName(
                        category.name,
                      ),

                      style: AppTypography.s14
                          .withFontWeight(FontWeight.w600)
                          .withColor(
                            isSelected ? Colors.white : AppColors.selectTab,
                          ),
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
