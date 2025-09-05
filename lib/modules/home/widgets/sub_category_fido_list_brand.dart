import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/home_controller.dart';
import '../../../core/theme/app_colors.dart';

class SubCategoryFidoListBrand extends StatelessWidget {
  const SubCategoryFidoListBrand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final subCategories = controller.subCategories
          .where((subCategory) => subCategory.id != 1)
          .toList();

      return SizedBox(
        height: 82.h, // vừa đủ cho 2 hàng hình ảnh nhỏ
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 12.w),
              ...List.generate((subCategories.length / 2).ceil(), (colIndex) {
                final item1 = subCategories[colIndex * 2];
                final item2 = (colIndex * 2 + 1 < subCategories.length)
                    ? subCategories[colIndex * 2 + 1]
                    : null;

                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Column(
                    children: [
                      _buildSubCategoryItem(item1, controller),
                      SizedBox(height: 10.h),
                      if (item2 != null)
                        _buildSubCategoryItem(item2, controller),
                    ],
                  ),
                );
              }),
            //  SizedBox(width: 12.w),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSubCategoryItem(subCategory, HomeController controller) {
    return InkWell(
      onTap: () => controller.selectSubCategory(subCategory.id),
      child: Container(
        width: 85.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: AppColors.neutral07,
          borderRadius: BorderRadius.circular(4.r),

        ),
        child: Center(
          child: Image.asset(
            subCategory.imgUrl,
            // width: 28.w,
            // height: 28.h,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.broken_image, size: 24.sp),
          ),
        ),
      ),
    );
  }
}
