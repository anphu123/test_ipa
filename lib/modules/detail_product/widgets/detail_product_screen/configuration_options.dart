import 'package:fido_box_demo01/core/common_widget/currency_util.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/locale_keys.g.dart';
import '../../controllers/detail_product_controller.dart';

class ConfigurationOptions extends GetView<DetailProductController> {
  const ConfigurationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final product = controller.product;
    final price99 = formatCurrency(product.price);
    final price95 = formatCurrency((product.price * 0.9).round());

    return Obx(() {
      final selected = controller.selectedQuality.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text( LocaleKeys.same_style_price.trans(),
              style: AppTypography.s14.medium.withColor(AppColors.neutral03)),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectQuality(99),
                  child: _ConfigOption(
                    percentage: '99%',
                    price: price99,
                    isSelected: selected == 99,
                    imageUrl: product.imgUrlp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectQuality(95),
                  child: _ConfigOption(
                    percentage: '95%',
                    price: price95,
                    isSelected: selected == 95,
                    imageUrl: product.imgUrlp,
                    hasWarning: true,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${LocaleKeys.same_style_price.trans()} 341 ${LocaleKeys.items_count_mh.trans()}',
                  style:
                  AppTypography.s12.regular.withColor(AppColors.neutral04)),
            ],
          ),
        ],
      );
    });
  }
}

class _ConfigOption extends StatelessWidget {
  const _ConfigOption({
    required this.percentage,
    required this.price,
    required this.isSelected,
    required this.imageUrl,
    this.hasWarning = false,
  });

  final String percentage;
  final String price;
  final bool isSelected;
  final String? imageUrl;
  final bool hasWarning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? AppColors.primary01 : Colors.grey[300]!,
          width: isSelected ? 2.w : 1.w,
        ),
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: imageUrl == null
                ? const SizedBox.shrink()
                : Image.network(imageUrl!),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (hasWarning)
                      Container(
                        width: 16.w,
                        height: 16.w,
                        decoration:
                        const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: Icon(Icons.warning, size: 10.sp, color: Colors.white),
                      ),
                    if (hasWarning) SizedBox(width: 4.w),
                    Text(
                      percentage,
                      style: AppTypography.s14.semibold,
                    ),
                  ],
                ),
                Text(price, style: AppTypography.s12.regular.withColor(AppColors.neutral04)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}