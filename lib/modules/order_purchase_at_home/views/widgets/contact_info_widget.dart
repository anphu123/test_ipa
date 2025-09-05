import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_home_controller.dart';

class ContactInfoWidget extends GetView<OrderPurchaseAtHomeController> {
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
            LocaleKeys.contact_info_title.trans(),
            style: AppTypography.s14.medium.copyWith(color: AppColors.neutral01),
          ),
          SizedBox(height: 12.h),

          Obx(() => Column(
            children: [
              _buildDetailRow(LocaleKeys.phone_label.trans(),        controller.customerPhone),
              _buildDetailRow(LocaleKeys.contact_name_label.trans(), controller.customerName),
              _buildDetailRow(LocaleKeys.address_label.trans(),      controller.customerAddress),
              _buildDetailRow(LocaleKeys.time_label.trans(),         controller.pickupDateTime),
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
}
