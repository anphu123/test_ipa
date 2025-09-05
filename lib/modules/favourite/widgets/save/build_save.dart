import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../controllers/saved_product_controller.dart';
import 'saved_product_card.dart';

class SavedProductView extends StatelessWidget {
  const SavedProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SavedProductController());

    return Scaffold(
      backgroundColor: AppColors.neutral07,
      appBar: AppBar(
        //  Text("Đã lưu"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Tổng ${controller.products.length} món / Mỗi sản phẩm chỉ có 1 cái",
          //  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          style: AppTypography.s12.regular.withColor(AppColors.neutral01),
        ),
        //centerTitle: true,
        // backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thông tin thống kê
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          ),

          // Danh sách sản phẩm
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (_, index) {
                  final product = controller.products[index];
                  return SavedProductCard(product: product);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
