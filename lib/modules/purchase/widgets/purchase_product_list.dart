import 'package:fido_box_demo01/core/common_widget/currency_util.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/purchase_controller.dart';

Widget PurchaseProductList() {
  final controller = Get.find<PurchaseController>();

  return Obx(() {
    return Column(
      children: List.generate(controller.products.length, (index) {
        final product = controller.products[index];
        final isSelected = controller.selectedIndexes.contains(index);

        return Column(
          children: [
            GestureDetector(
              onTap: () => controller.toggleProductSelection(index),

              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(color: AppColors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle : Icons.radio_button_off,
                      size: 24.sp,
                      color:
                          isSelected
                              ? AppColors.primary01
                              : AppColors.neutral05,
                    ),
                    SizedBox(width: 12.w),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        product.image,
                        width: 60.w,
                        height: 60.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.sendOrderPurchase,
                                    arguments: {
                                      'product': product,
                                      'index': index,
                                    },
                                  );
                                },
                                child: Text(
                                  "Sửa",
                                  style: AppTypography.s14.semibold.withColor(
                                    AppColors.neutral02,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),

                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "₫${formatCurrency(product.price)}",
                                  style: AppTypography.s12.semibold.withColor(
                                    AppColors.neutral01,
                                  ),
                                ),
                                TextSpan(text: "  "),
                                TextSpan(
                                  text: "Giá ước tính",
                                  style: AppTypography.s10.regular.withColor(
                                    AppColors.neutral04,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Giảm giá (18%) : ₫${formatCurrency(int.parse(product.discount))}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Text(
                            "Ưu đãi khi thu hồi : ₫${formatCurrency(int.parse(product.bonus))}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ✅ Divider dưới mỗi item trừ item cuối cùng
            if (index != controller.products.length - 1)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: Container(height: 1, color: AppColors.neutral07),
              ),
          ],
        );
      }),
    );
  });
}
