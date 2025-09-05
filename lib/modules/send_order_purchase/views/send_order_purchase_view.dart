import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/send_order_purchase_controller.dart';

class SendOrderPurchaseView extends GetView<SendOrderPurchaseController> {
  const SendOrderPurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text('Chỉnh sửa sản phẩm', style: AppTypography.s16.bold),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.neutral01,
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tên sản phẩm', style: AppTypography.s14.medium),
            SizedBox(height: 8.h),
            TextField(
              controller: TextEditingController(text: controller.product.name),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
           //     controller.product.name = value;
              },
            ),
            SizedBox(height: 16.h),
            Text('Giá sản phẩm', style: AppTypography.s14.medium),
            SizedBox(height: 8.h),
            TextField(
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: controller.product.price.toString()),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                //controller.product.price = int.tryParse(value) ?? 0;
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Trả về sản phẩm đã chỉnh sửa
                Get.back(result: {
                  'product': controller.product,
                  'index': controller.index,
                });
              },
              child: Text("Lưu"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
                backgroundColor: AppColors.primary01,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
