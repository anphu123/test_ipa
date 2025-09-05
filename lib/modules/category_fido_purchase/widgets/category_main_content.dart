import 'package:fido_box_demo01/modules/category_fido_purchase/widgets/phone_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/category_fido_purchase_controller.dart';
import 'brand_grid.dart';
import 'featured_product_card.dart';

class CategoryMainContent extends StatelessWidget {
  final CategoryFidoPurchaseController controller;

  const CategoryMainContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final index = controller.selectedIndex.value;
      return SingleChildScrollView(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                controller.bannerImages[index] ?? '',
                height: 63.h,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 16.h),
            // Các widget con như FeaturedProductCard(), BrandGrid(), PhoneList() tách tiếp nếu muốn
            Row(
              children: [
                FeaturedProductCard(
                  imagePath: controller.featuredProductImage[index] ?? '',
                  name: controller.featuredProductName[index] ?? '',
                  price: controller.featuredProductPrice[index] ?? '',
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Container(
                    height: 92.h,
                    width: 115.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.neutral08,
                      //  border: Border.all(color: Colors.grey.shade300),
                    ),
                    // padding: EdgeInsets.all(12.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 30),
                        SizedBox(height: 5),
                        Text(
                          "Giỏ hàng (0)",
                          style: AppTypography.s12.regular.withColor(
                            AppColors.neutral01,
                          ),
                        ),
                        Text(
                          "nhiều vật phẩm",
                          style: AppTypography.s12.regular.withColor(
                            AppColors.neutral04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Text(
            // //  controller.categoryName[index]?? '',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            BrandGrid(brands: controller.brandByCategory[index] ?? []),
            SizedBox(height: 16.h),
            PhoneList(phones: controller.popularModelsByCategory[index] ?? []),
          ],
        ),
      );
    });
  }
}
