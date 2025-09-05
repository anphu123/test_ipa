import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_store_controller.dart';

class StorePickupStatusWidget extends GetView<OrderPurchaseAtStoreController> {
  const StorePickupStatusWidget({super.key});

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
          // Header
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
                  Icons.store,
                  color: AppColors.primary01,
                  size: 20.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trạng thái đơn hàng',
                      style: AppTypography.s14.medium.copyWith(
                        color: AppColors.neutral01,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Obx(() => Text(
                      controller.orderStatusText,
                      style: AppTypography.s12.regular.copyWith(
                        color: controller.orderStatusColor,
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Timeline
          _buildTimeline(),
          SizedBox(height: 16.h),

          // Pickup info
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.neutral07,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primary01,
                      size: 16.r,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Thông tin nhận hàng',
                      style: AppTypography.s12.medium.copyWith(
                        color: AppColors.neutral01,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  '• Vui lòng mang theo CMND/CCCD khi đến nhận hàng\n'
                  '• Kiểm tra kỹ sản phẩm trước khi nhận\n'
                  '• Thanh toán tại cửa hàng',
                  style: AppTypography.s12.regular.copyWith(
                    color: AppColors.neutral03,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Obx(() {
      final currentStatus = controller.orderStatus.value;
      final statuses = [
        {'key': 'waiting_confirmation', 'title': 'Chờ xác nhận', 'time': ''},
        {'key': 'confirmed', 'title': 'Đã xác nhận', 'time': ''},
        {'key': 'preparing', 'title': 'Đang chuẩn bị', 'time': ''},
        {'key': 'ready_for_pickup', 'title': 'Sẵn sàng nhận hàng', 'time': ''},
        {'key': 'completed', 'title': 'Hoàn thành', 'time': ''},
      ];

      return Column(
        children: statuses.asMap().entries.map((entry) {
          final index = entry.key;
          final status = entry.value;
          final isActive = _getStatusIndex(currentStatus) >= index;
          final isCurrent = currentStatus == status['key'];

          return Row(
            children: [
              // Timeline dot
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary01 : AppColors.neutral05,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isCurrent ? AppColors.primary01 : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: isActive
                    ? Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 12.r,
                      )
                    : null,
              ),
              SizedBox(width: 12.w),

              // Status info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status['title']!,
                      style: AppTypography.s12.medium.copyWith(
                        color: isActive ? AppColors.neutral01 : AppColors.neutral03,
                      ),
                    ),
                    if (status['time']!.isNotEmpty)
                      Text(
                        status['time']!,
                        style: AppTypography.s10.regular.copyWith(
                          color: AppColors.neutral03,
                        ),
                      ),
                  ],
                ),
              ),

              // Timeline line (except for last item)
              if (index < statuses.length - 1)
                Container(
                  width: 2.w,
                  height: 30.h,
                  color: isActive ? AppColors.primary01 : AppColors.neutral05,
                ),
            ],
          );
        }).toList(),
      );
    });
  }

  int _getStatusIndex(String status) {
    switch (status) {
      case 'waiting_confirmation':
        return 0;
      case 'confirmed':
        return 1;
      case 'preparing':
        return 2;
      case 'ready_for_pickup':
        return 3;
      case 'completed':
        return 4;
      default:
        return 0;
    }
  }
}
