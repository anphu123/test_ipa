import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../controllers/category_fido_purchase_controller.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryFidoPurchaseController>();
    final TextEditingController searchController = TextEditingController();

    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 60.h,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          children: [
            // Back button
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              color: Colors.black,
              onPressed: () {
                if (controller.isSearching.value) {
                  controller.stopSearch();
                  searchController.clear();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),

            // Search field
            Expanded(
              child: Container(
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.neutral04, width: 1.w),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.images.icSearch.path,
                      color: AppColors.neutral04,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: LocaleKeys.search_placeholder.trans(),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: AppTypography.s14.regular.withColor(
                          AppColors.neutral01,
                        ),
                        onChanged: (value) {
                          controller.updateSearchQuery(value);
                        },
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            controller.selectSearchResult(value);
                          }
                        },
                      ),
                    ),
                    Obx(() => controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, size: 16),
                            onPressed: () {
                              searchController.clear();
                              controller.updateSearchQuery('');
                            },
                          )
                        : SizedBox.shrink()),
                  ],
                ),
              ),
            ),

            // "Tìm kiếm" button
            SizedBox(width: 8.w),
            Obx(() => GestureDetector(
                  onTap: () {
                    if (controller.searchQuery.value.isNotEmpty) {
                      controller.selectSearchResult(controller.searchQuery.value);
                    } else {
                      Get.snackbar(
                        LocaleKeys.notification.trans(),
                        'Vui lòng nhập từ khóa tìm kiếm',
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: controller.searchQuery.value.isNotEmpty
                          ? AppColors.primary01
                          : AppColors.neutral05,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      LocaleKeys.search.trans(),
                      style: AppTypography.s14.medium.withColor(
                        controller.searchQuery.value.isNotEmpty
                            ? AppColors.white
                            : AppColors.neutral03,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}