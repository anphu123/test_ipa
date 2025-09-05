import 'package:fido_box_demo01/modules/favourite/widgets/history/viewed_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/viewed_product_controller.dart';

class HistoryViewedScreen extends StatelessWidget {
  final controller = Get.put(ViewedProductController());

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          'Lịch sử đã xem',
          style: AppTypography.s16.bold.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        // Ngăn đổi màu khi scroll
        elevation: 0.5,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                controller.selectionMode.value
                    ? Icons.close
                    : Icons.delete_outlined,
                color: AppColors.neutral01,
              ),
              onPressed: controller.toggleSelectionMode,

            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_sweep,
              color: AppColors.neutral01,
            ),
            onPressed: () {
              if (controller.viewedProducts.isNotEmpty) {
                Get.defaultDialog(
                  title: "Xác nhận xoá tất cả",
                  middleText: "Bạn có chắc muốn xoá tất cả sản phẩm đã xem?",
                  textCancel: "Huỷ",
                  textConfirm: "Xoá tất cả",
                  confirmTextColor: Colors.white,
                  buttonColor: AppColors.primary01,
                  onConfirm: () {
                    controller.deleteAll();
                    Get.back(); // Close dialog after deletion
                  },
                );
              }
            },
          ),
        ],
      ),

      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: ListView(
                  children:
                      controller.groupedByDate.entries.map((entry) {
                        final dateLabel = entry.key;
                        final products = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                dateLabel,
                                style: AppTypography.s14.bold.withColor(
                                  AppColors.neutral01,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            ...products.map(
                              (p) => ViewedProductCard(
                                product: p,
                                isSelected: controller.isSelected(p.id),
                                onChanged:
                                    () => controller.toggleSelection(p.id),
                                showCheckbox: controller.selectionMode.value,
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ),
            Obx(() {
              if (controller.selectionMode.value &&
                  controller.selectedIds.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.all(12.w),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Xác nhận xoá",
                        middleText:
                            "Bạn có chắc muốn xoá ${controller.selectedIds.length} sản phẩm đã chọn?",
                        textCancel: "Huỷ",
                        textConfirm: "Xoá",
                        confirmTextColor: Colors.white,
                        buttonColor: AppColors.primary01,
                        onConfirm: () {
                          controller.deleteSelected();
                          Get.back(); // Đóng dialog sau khi xoá
                        },
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary01,
                      minimumSize: Size(double.infinity, 48.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Xoá (${controller.selectedIds.length}) sản phẩm đã chọn",
                      style: AppTypography.s14.withColor(Colors.white),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            }),
          ],
        );
      }),
    );
  }

  // Widget _buildViewedItem(ViewedProductModel product) {
  //   return Container(
  //     padding: EdgeInsets.all(12.w),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12.r),
  //     ),
  //     child: Row(
  //       children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(8.r),
  //           child: Image.network(
  //             product.imageUrl,
  //             width: 100.w,
  //             height: 100.w,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         SizedBox(width: 12.w),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 children: [
  //                   _buildChip("C", color: AppColors.AS01),
  //                   SizedBox(width: 4.w),
  //                   Expanded(
  //                     child: Text(
  //                       "${product.conditionLabel} ${product.name}",
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: AppTypography.s14.medium,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: 8.h),
  //               Text(
  //                 formatCurrency(product.price),
  //                 style: TextStyle(
  //                   fontSize: 16.sp,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildChip(String label, {Color? color}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: AppTypography.s9.bold.copyWith(color: Colors.white),
      ),
    );
  }
}
