import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_home_controller.dart';

// 👇 i18n
import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/extensions/string_extension.dart';

class OrderInfoWidget extends GetView<OrderPurchaseAtHomeController> {
  const OrderInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo 1 lần nếu trống
    if (controller.orderId.value.isEmpty) {
      controller.orderId.value = _generateOrderId();
    }
    controller.orderCreatedAt.value ??= DateTime.now();

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
            LocaleKeys.order_info_title.trans(), // "Thông tin đơn hàng"
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
                LocaleKeys.order_code_label.trans(), // "Mã đơn hàng"
                style: AppTypography.s14.regular.copyWith(
                  color: AppColors.neutral03,
                ),
              ),
              Row(
                children: [
                  Obx(() => Text(
                    controller.orderId.value,
                    style: AppTypography.s14.medium.copyWith(
                      color: AppColors.neutral01,
                    ),
                  )),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: _copyOrderId,
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
                LocaleKeys.order_time_label.trans(), // "Thời gian đặt hàng"
                style: AppTypography.s14.regular.copyWith(
                  color: AppColors.neutral03,
                ),
              ),
              Obx(() {
                final dt = controller.orderCreatedAt.value ?? DateTime.now();
                return Text(
                  _formatOrderDate(dt),
                  style: AppTypography.s14.medium.copyWith(
                    color: AppColors.neutral01,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  String _generateOrderId() {
    // VD: OD-yyMMddHHmmss-xxxx
    final now = DateTime.now();
    final ts =
        '${(now.year % 100).toString().padLeft(2, '0')}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
    final rand = (now.millisecondsSinceEpoch % 10000).toString().padLeft(4, '0');
    return 'OD-$ts-$rand';
  }

  String _formatOrderDate(DateTime dt) {
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year.toString();
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    final second = dt.second.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute:$second';
  }

  void _copyOrderId() {
    final orderId = controller.orderId.value; // copy đúng cái đang hiển thị
    Clipboard.setData(ClipboardData(text: orderId));

    Get.snackbar(
      LocaleKeys.copied_title.trans(), // "Đã sao chép"
      LocaleKeys.copied_order_message.trans(), // "Mã đơn hàng đã được sao chép vào clipboard"
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.success.withOpacity(0.1),
      colorText: AppColors.success,
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.all(16.w),
      borderRadius: 8.r,
      icon: Icon(Icons.check_circle, color: AppColors.success),
    );
  }
}
