import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_store_controller.dart';

class ContactInfoWidget extends GetView<OrderPurchaseAtStoreController> {
  const ContactInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.neutral06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin liên hệ',
            style: AppTypography.s14.medium.copyWith(
              color: AppColors.neutral01,
            ),
          ),
          SizedBox(height: 12.h),

          // Customer info
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primary01.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.primary01,
                  size: 20.r,
                ),
              ),
              SizedBox(width: 12.w),
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
                    SizedBox(height: 2.h),
                    Obx(() => Text(
                      controller.customerPhone,
                      style: AppTypography.s12.regular.copyWith(
                        color: AppColors.neutral03,
                      ),
                    )),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _callCustomer(),
                icon: Icon(
                  Icons.phone,
                  color: AppColors.primary01,
                  size: 20.r,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Pickup method
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.neutral07,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.store,
                  color: AppColors.primary01,
                  size: 16.r,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phương thức nhận hàng',
                        style: AppTypography.s12.medium.copyWith(
                          color: AppColors.neutral01,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Obx(() => Text(
                        controller.pickupMethod,
                        style: AppTypography.s11.regular.copyWith(
                          color: AppColors.neutral03,
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // Pickup time
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.neutral07,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: AppColors.primary01,
                  size: 16.r,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thời gian hẹn',
                        style: AppTypography.s12.medium.copyWith(
                          color: AppColors.neutral01,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Obx(() => Text(
                        controller.orderDateTime.isNotEmpty 
                            ? controller.orderDateTime 
                            : 'Chưa xác định',
                        style: AppTypography.s11.regular.copyWith(
                          color: AppColors.neutral03,
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _callCustomer() {
    // Implement call customer functionality
    Get.snackbar(
      'Gọi khách hàng',
      'Tính năng gọi điện đang được phát triển',
      snackPosition: SnackPosition.TOP,
    );
  }
}
