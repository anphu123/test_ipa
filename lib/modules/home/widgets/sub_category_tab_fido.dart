import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/home_controller.dart';

class SubCategoryTabFido extends StatelessWidget {
  const SubCategoryTabFido({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final PageController pageController = PageController();
    final RxInt currentPage = 0.obs;

    return Obx(() {
      final subCategories = controller.subCategories;
      if (subCategories.isEmpty) return SizedBox.shrink();

      final pages = <List<dynamic>>[];
      for (int i = 0; i < subCategories.length; i += 4) {
        final end =
            (i + 4 < subCategories.length) ? i + 4 : subCategories.length;
        pages.add(subCategories.sublist(i, end));
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 90.h,
            child: PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) => currentPage.value = index,
              itemBuilder: (context, pageIndex) {
                final items = pages[pageIndex];

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      items.map<Widget>((subCategory) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectSubCategory(subCategory.id);
                            print('Selected SubCategory: ${subCategory.name}');
                          },
                          child: Obx(() {
                            final isSelected =
                                controller.selectedSubCategoryId.value ==
                                subCategory.id;

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 48.w,
                                  height: 48.w,
                                  decoration: BoxDecoration(
                                    //   shape: BoxShape.circle,

                                    // border: Border.all(
                                    //   color: isSelected
                                    //       ? AppColors.primary01
                                    //       : Colors.transparent,
                                    //   width: 2,
                                    // ),
                                  ),
                                  child: Image.asset(
                                    subCategory.imgUrl ?? '',
                                    fit: BoxFit.scaleDown,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                          Icons.image_not_supported,
                                          size: 20.sp,
                                        ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                SizedBox(
                                  width: 60.w,
                                  child: Text(
                                    controller.getTranslatedSubCategoryName(
                                      subCategory.name,
                                    ),
                                    style: AppTypography.s10.medium.copyWith(
                                      color:
                                          isSelected
                                              ? AppColors.primary01
                                              : Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          }),
                        );
                      }).toList(),
                );
              },
            ),
          ),
         // SizedBox(height: 1.h),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) {
                final isActive = index == currentPage.value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  width: isActive ? 20.w : 6.w,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color:
                        isActive ? AppColors.primary01 : Colors.grey.shade300,
                  // /  shape: BoxShape.,
                  ),
                );
              }),
            ),
          ),
        ],
      );
    });
  }
}
