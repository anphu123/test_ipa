import 'package:fido_box_demo01/modules/purchase/controllers/purchase_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/common_widget/currency_util.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/purchase_app_bar.dart';
import '../widgets/purchase_content.dart';

class PurchaseView extends GetView<PurchaseController> {
  const PurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                PurchaseAppBar(),
                SliverToBoxAdapter(
                  child: Column(
                    children: [PurchaseContent(), SizedBox(height: 30.h)],
                  ),
                ),
              ],
            ),
          ),

          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Obx(() {
      final total = controller.totalPrice.value;

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: "Tổng tiền\n",
                  style: TextStyle(color: Colors.black54, fontSize: 12.sp),
                  children: [
                    TextSpan(
                      text: "${formatCurrency(controller.totalPrice.value)}",
                      style: TextStyle(
                        color: AppColors.primary01,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary01,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Obx(
                () => Text(
                  "Mua hàng  (${controller.selectedIndexes.length})",
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}
