import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_home_controller.dart';

class SellerInfoWidget extends GetView<OrderPurchaseAtHomeController> {
  const SellerInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.neutral06),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.neutral07,
            child: Icon(
              Icons.person,
              color: AppColors.neutral03,
              size: 24.r,
            ),
          ),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  controller.customerName,
                  style: AppTypography.s14.medium.copyWith(
                    color: AppColors.neutral01,
                  ),
                )),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16.r),
                    SizedBox(width: 4.w),
                    Text(
                      '4.8',
                      style: AppTypography.s12.regular.copyWith(
                        color: AppColors.neutral03,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action buttons
          Row(
            children: [
              _buildActionButton(Icons.chat_bubble_outline, 'Chat', controller.chatWithCustomer),
              SizedBox(width: 8.w),
              _buildActionButton(Icons.phone_outlined, 'Gọi điện', controller.callCustomer),
              SizedBox(width: 8.w),
              _buildActionButton(Icons.location_on_outlined, 'Vị trí', controller.showLocation),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.neutral08,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: AppColors.neutral03,
              size: 20.r,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTypography.s10.regular.copyWith(
              color: AppColors.neutral03,
            ),
          ),
        ],
      ),
    );
  }
}
