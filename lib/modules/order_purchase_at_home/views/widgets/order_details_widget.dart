import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/common_widget/currency_util.dart';
import '../../controllers/order_purchase_at_home_controller.dart';

// 👇 thêm 2 import cho i18n
import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/extensions/string_extension.dart';

class OrderDetailsWidget extends GetView<OrderPurchaseAtHomeController> {
  const OrderDetailsWidget({super.key});

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
            LocaleKeys.product_info_title.trans(),
            style: AppTypography.s14.medium.copyWith(
              color: AppColors.neutral01,
            ),
          ),
          SizedBox(height: 12.h),

          Obx(() => Column(
            children: [
              _buildDetailRow(
                LocaleKeys.product_name_label.trans(),
                '${controller.productModel} ${controller.productCapacity}',
              ),
              _buildDetailRow(
                LocaleKeys.capacity_label.trans(),
                controller.productCapacity,
              ),
              _buildDetailRow(
                LocaleKeys.version_label.trans(),
                controller.productVersion,
              ),
              _buildDetailRow(
                LocaleKeys.warranty_label.trans(),
                controller.warranty,
              ),
              _buildDetailRow(
                LocaleKeys.battery_status_label.trans(),
                controller.batteryStatus,
              ),
              _buildDetailRow(
                LocaleKeys.exterior_label.trans(),
                controller.appearance,
              ),
            ],
          )),

          SizedBox(height: 16.h),
          Divider(color: AppColors.neutral06),
          SizedBox(height: 16.h),

          // Price section
          Text(
            LocaleKeys.payment_info_title.trans(),
            style: AppTypography.s14.medium.copyWith(
              color: AppColors.neutral01,
            ),
          ),
          SizedBox(height: 12.h),

          Obx(() => Column(
            children: [
              _buildPriceRow(
                LocaleKeys.estimated_price_label.trans(),
                controller.evaluatedPrice,
              ),
              if (controller.selectedVoucher != null)
                _buildPriceRow(
                  LocaleKeys.voucher_applied_label.trans(),
                  controller.voucherDiscount,
                  isDiscount: true,
                ),

              SizedBox(height: 8.h),
              Divider(color: AppColors.neutral06),
              SizedBox(height: 8.h),

              _buildPriceRow(
                LocaleKeys.total_label.trans(),
                controller.finalPrice,
                isBold: true,
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: AppTypography.s12.regular.copyWith(
                color: AppColors.neutral03,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.s12.regular.copyWith(
                color: AppColors.neutral01,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
      String label,
      int amount, {
        bool isDiscount = false,
        bool isBold = false,
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: (isBold ? AppTypography.s14.bold : AppTypography.s14.regular)
                .copyWith(color: AppColors.neutral01),
          ),
          Text(
            '${isDiscount ? '+' : ''}${formatCurrency(amount)}',
            style: (isBold ? AppTypography.s14.bold : AppTypography.s14.regular)
                .copyWith(
              color: isDiscount
                  ? AppColors.success
                  : (isBold ? AppColors.error : AppColors.neutral01),
            ),
          ),
        ],
      ),
    );
  }
}
