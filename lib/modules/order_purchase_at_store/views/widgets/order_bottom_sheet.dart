import 'staff_info_widget_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import 'store_pickup_status_widget.dart';
import 'product_info_widget.dart';
import 'promotion_banner_widget.dart';
import 'contact_info_widget.dart';
import 'reward_notification_widget.dart';
import 'payment_info_widget.dart';
import 'order_info_widget.dart';

class OrderBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const OrderBottomSheet({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.neutral06,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Staff info
                  const StaffInfoWidget(),
                  SizedBox(height: 16.h),
                  // Store pickup status
                  // const StorePickupStatusWidget(),
                  SizedBox(height: 16.h),

                  // Promotion banner
                  PromotionBannerWidget(),
                  SizedBox(height: 16.h),

                  // Reward notification
                  RewardNotificationWidget(),
                  SizedBox(height: 16.h),

                  // Product info
                  const ProductInfoWidget(),
                  SizedBox(height: 16.h),
                  //
                  // // Contact info
                  // const ContactInfoWidget(),
                  // SizedBox(height: 16.h),

                  // Payment info
                  const PaymentInfoWidget(),
                  SizedBox(height: 16.h),

                  // Order info
                  const OrderInfoWidget(),
                  SizedBox(height: 30.h), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
