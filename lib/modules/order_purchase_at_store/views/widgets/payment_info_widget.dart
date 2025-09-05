import 'package:fido_box_demo01/modules/order_purchase_at_store/controllers/order_purchase_at_store_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PaymentInfoWidget extends GetView<OrderPurchaseAtStoreController> {
  const PaymentInfoWidget({super.key});

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
            'Thông tin nhận tiền',
            style: AppTypography.s16.regular.copyWith(
              color: AppColors.neutral01,
            ),
          ),
          SizedBox(height: 16.h),

          // ATM Card Section
          Row(
            children: [
              // ATM Card Icon
              Container(
                  width: 40.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Color(0xFFFF6B35),
                    //     Color(0xFFFF9A5C),
                    //   ],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child:Image.asset(Assets.images.icThongtinnhantien.path)
              ),
              SizedBox(width: 12.w),

              // Card Info
              Expanded(
                child: Text(
                  'Thẻ ATM nội địa',
                  style: AppTypography.s14.medium.copyWith(
                    color: AppColors.neutral01,
                  ),
                ),
              ),

              // Link Button
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.neutral04),
                ),
                child: Text(
                  'Liên kết',
                  style: AppTypography.s14.medium.copyWith(
                    color: AppColors.neutral01,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: AppColors.neutral07,),
          // Add Payment Method
          GestureDetector(
            onTap: () => _showAddPaymentMethodBottomSheet(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Thêm phương thức nhận tiền khác',
                  style: AppTypography.s14.regular.copyWith(
                    color: AppColors.neutral03,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.neutral03,
                  size: 20.r,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddPaymentMethodBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thêm phương thức nhận tiền',
                  style: AppTypography.s16.bold.copyWith(
                    color: AppColors.neutral01,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: AppColors.neutral03,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Payment methods list
            _buildPaymentMethodItem(
              icon: Icons.account_balance,
              title: 'Tài khoản ngân hàng',
              subtitle: 'Liên kết tài khoản ngân hàng',
              onTap: () {
                Get.back();
                // Navigate to bank account linking
              },
            ),
            SizedBox(height: 12.h),

            _buildPaymentMethodItem(
              icon: Icons.account_balance_wallet,
              title: 'Ví điện tử',
              subtitle: 'MoMo, ZaloPay, ViettelPay...',
              onTap: () {
                Get.back();
                // Navigate to e-wallet linking
              },
            ),
            SizedBox(height: 12.h),

            _buildPaymentMethodItem(
              icon: Icons.credit_card,
              title: 'Thẻ tín dụng',
              subtitle: 'Visa, Mastercard, JCB...',
              onTap: () {
                Get.back();
                // Navigate to credit card linking
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildPaymentMethodItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.neutral07,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.neutral06),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColors.primary01.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
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
                    title,
                    style: AppTypography.s14.medium.copyWith(
                      color: AppColors.neutral01,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: AppTypography.s12.regular.copyWith(
                      color: AppColors.neutral03,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.neutral03,
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}
