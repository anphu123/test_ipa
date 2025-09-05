import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class OrderInfoWidget extends StatelessWidget {
  const OrderInfoWidget({super.key});

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
          // Title
          Text(
            'Thông tin đơn hàng',
            style: AppTypography.s16.bold.copyWith(
              color: AppColors.neutral01,
            ),
          ),
          SizedBox(height: 16.h),

          // Order ID Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mã đơn hàng',
                style: AppTypography.s14.regular.copyWith(
                  color: AppColors.neutral03,
                ),
              ),
              Row(
                children: [
                  Text(
                    _generateOrderId(),
                    style: AppTypography.s14.medium.copyWith(
                      color: AppColors.neutral01,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => _copyOrderId(),
                    child: Icon(
                      Icons.copy,
                      size: 16.r,
                      color: AppColors.neutral03,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Order Date Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thời gian đặt hàng',
                style: AppTypography.s14.regular.copyWith(
                  color: AppColors.neutral03,
                ),
              ),
              Text(
                _formatOrderDate(),
                style: AppTypography.s14.medium.copyWith(
                  color: AppColors.neutral01,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _generateOrderId() {
    // Generate order ID based on current timestamp
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return timestamp.toString();
  }

  String _formatOrderDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year.toString();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    
    return '$day/$month/$year $hour:$minute:$second';
  }

  void _copyOrderId() {
    final orderId = _generateOrderId();
    Clipboard.setData(ClipboardData(text: orderId));
    
    Get.snackbar(
      'Đã sao chép',
      'Mã đơn hàng đã được sao chép vào clipboard',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.success.withOpacity(0.1),
      colorText: AppColors.success,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(16.w),
      borderRadius: 8.r,
      icon: Icon(
        Icons.check_circle,
        color: AppColors.success,
      ),
    );
  }
}
