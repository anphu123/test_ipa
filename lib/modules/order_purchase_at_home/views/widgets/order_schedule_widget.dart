import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_home_controller.dart';

class OrderScheduleWidget extends GetView<OrderPurchaseAtHomeController> {
  const OrderScheduleWidget({super.key});

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
          // Schedule info
          RichText(
            text: TextSpan(
              style: AppTypography.s14.regular.copyWith(
                color: AppColors.neutral01,
              ),
              children: [
                TextSpan(text: LocaleKeys.courier_will_arrive_on.trans()),
                TextSpan(
                  text: 'Thứ Bảy, 26/07/2025, vào lúc 18:00-19:00',
                  style: AppTypography.s14.medium.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Phone number
          Text(
            '488 135****7227',
            style: AppTypography.s14.regular.copyWith(
              color: AppColors.neutral01,
            ),
          ),
          SizedBox(height: 8.h),

          // Address
          Text(
            '2 Trần Não, Phường An Khánh, Thủ Đức, Thành phố Hồ Chí Minh',
            style: AppTypography.s14.regular.copyWith(
              color: AppColors.neutral01,
            ),
          ),
          SizedBox(height: 16.h),

          // Change button
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.neutral06),
            ),
            child: Text(
              LocaleKeys.change_address_time.trans(),
              style: AppTypography.s14.regular.copyWith(
                color: AppColors.neutral02,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.h),

          // Status timeline
          _buildStatusTimeline(),
        ],
      ),
    );
  }

  Widget _buildStatusTimeline() {
    return Row(
      children: [
        // Step 1: Đặt lịch thành công
        Expanded(
          child: _buildStatusStep(
            icon: Icons.check_circle,
            label: LocaleKeys.step_booked_success.trans(),
            isCompleted: true,
            isActive: false,
          ),
        ),
        
        // Line 1
        Expanded(
          child: Container(
            height: 2.h,
            color: AppColors.neutral06,
          ),
        ),

        // Step 2: Bưu tá kiểm tra
        Expanded(
          child: _buildStatusStep(
            icon: Icons.search,
            label: LocaleKeys.step_courier_inspection.trans(),
            isCompleted: false,
            isActive: false,
          ),
        ),

        // Line 2
        Expanded(
          child: Container(
            height: 2.h,
            color: AppColors.neutral06,
          ),
        ),

        // Step 3: Định giá, thanh toán
        Expanded(
          child: _buildStatusStep(
            icon: Icons.payment,
            label: LocaleKeys.step_valuation_payment.trans(),
            isCompleted: false,
            isActive: false,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusStep({
    required IconData icon,
    required String label,
    required bool isCompleted,
    required bool isActive,
  }) {
    return Column(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.success : AppColors.neutral06,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : icon,
            color: AppColors.white,
            size: 20.r,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: AppTypography.s10.regular.copyWith(
            color: isCompleted ? AppColors.success : AppColors.neutral03,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
