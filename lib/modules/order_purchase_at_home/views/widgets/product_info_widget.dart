import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/common_widget/currency_util.dart';
import '../../controllers/order_purchase_at_home_controller.dart';

// ⬇️ Thêm import i18n
import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/extensions/string_extension.dart';

class ProductInfoWidget extends StatefulWidget {
  const ProductInfoWidget({super.key});

  @override
  State<ProductInfoWidget> createState() => _ProductInfoWidgetState();
}

class _ProductInfoWidgetState extends State<ProductInfoWidget> {
  Timer? _countdownTimer;
  final RxString remainingTime = '06 ngày 23:59:05'.obs;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    // Set countdown to 7 days from now
    final endTime = DateTime.now().add(Duration(days: 7));

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final difference = endTime.difference(now);

      if (difference.isNegative) {
        timer.cancel();
        remainingTime.value = LocaleKeys.expired.trans(); // 'Đã hết hạn'
      } else {
        final days = difference.inDays;
        final hours = difference.inHours % 24;
        final minutes = difference.inMinutes % 60;
        final seconds = difference.inSeconds % 60;

        remainingTime.value =
        '${days.toString().padLeft(2, '0')} ${LocaleKeys.day_suffix.trans()} '
            '${hours.toString().padLeft(2, '0')}:'
            '${minutes.toString().padLeft(2, '0')}:'
            '${seconds.toString().padLeft(2, '0')}';
      }
    });
  }

  OrderPurchaseAtHomeController get controller =>
      Get.find<OrderPurchaseAtHomeController>();

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
          // Header with title and "Đánh giá của tôi" link
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.product_info_title.trans(), // 'Thông tin sản phẩm'
                style: AppTypography.s16.medium.copyWith(
                  color: AppColors.neutral01,
                ),
              ),
              GestureDetector(
                onTap: () => _showProductDetailsBottomSheet(),
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.my_evaluation.trans(), // 'Đánh giá của tôi'
                      style: AppTypography.s12.regular.copyWith(
                        color: AppColors.neutral04,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right,
                      color: AppColors.neutral03,
                      size: 16.r,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Product info row
          Row(
            children: [
              // Product image
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppColors.neutral07,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Image.asset(
                  Assets.images.pXiaomi15.path,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 12.w),

              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.productModel,
                      style: AppTypography.s12.regular.copyWith(
                        color: AppColors.neutral01,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      LocaleKeys.product_summary_example.trans(),
                      // 'Bản nội địa 256G (Thời hạn bảo hành >1 tháng), các chức nă...'
                      style: AppTypography.s10.regular.copyWith(
                        color: AppColors.neutral03,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Price details
          Obx(() {
            final basePrice = controller.evaluatedPrice;
            final voucherDiscount = controller.voucherDiscount;
            final selectedVoucher = controller.selectedVoucher;

            return Column(
              children: [
                _buildPriceRow(LocaleKeys.estimated_price.trans(), basePrice),
                if (selectedVoucher != null)
                  _buildPriceRow(
                    LocaleKeys.voucher_label.trans(),
                    voucherDiscount,
                    isDiscount: true,
                  ),
              ],
            );
          }),
          SizedBox(height: 12.h),
          Divider(color: AppColors.neutral07),

          // Countdown banner
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFFF9A5C),
                      Color(0xFFFF6B35),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Obx(
                      () => Text(
                        LocaleKeys.deal_expires_in.trans()
                            .replaceAll('{time}', remainingTime.value),


                        // 'Giá ưu đãi sẽ hết hạn sau {time}'
                    style: AppTypography.s10.medium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Total
          Obx(
                () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.total_amount.trans(), // 'Tổng cộng'
                  style: AppTypography.s16.bold.copyWith(
                    color: AppColors.neutral01,
                  ),
                ),
                Text(
                  formatCurrency(controller.finalPrice),
                  style: AppTypography.s16.bold.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showProductDetailsBottomSheet() {
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
                  LocaleKeys.product_details_title.trans(),
                  // 'Thông tin sản phẩm chi tiết'
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

            // Product details
            _buildDetailRow(
              LocaleKeys.product_name.trans(),
              controller.productModel,
            ),
            _buildDetailRow(LocaleKeys.capacity.trans(), '256GB'),
            _buildDetailRow(LocaleKeys.version.trans(), 'Bản nội địa'),
            _buildDetailRow(
              LocaleKeys.warranty.trans(),
              'Thời hạn bảo hành >1 tháng',
            ),
            _buildDetailRow(LocaleKeys.battery_health.trans(), 'Tốt (>80%)'),
            _buildDetailRow(LocaleKeys.exterior.trans(), 'Còn mới, không trầy xước'),
            _buildDetailRow(LocaleKeys.display.trans(), 'Hoạt động bình thường'),
            _buildDetailRow(LocaleKeys.camera.trans(), 'Hoạt động tốt'),
            _buildDetailRow(LocaleKeys.speaker_mic.trans(), 'Hoạt động bình thường'),
            _buildDetailRow(LocaleKeys.functions.trans(), 'Đầy đủ, hoạt động tốt'),

            SizedBox(height: 20.h),

            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary01,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  LocaleKeys.close.trans(), // 'Đóng'
                  style: AppTypography.s14.medium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
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

  Widget _buildPriceRow(String label, int amount, {bool isDiscount = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.s14.regular.copyWith(
              color: AppColors.neutral01,
            ),
          ),
          Text(
            '${isDiscount ? '+ ' : ''}${formatCurrency(amount)}',
            style: AppTypography.s14.regular.copyWith(
              color: isDiscount ? AppColors.primary01 : AppColors.neutral01,
            ),
          ),
        ],
      ),
    );
  }
}
