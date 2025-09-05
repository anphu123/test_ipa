import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

// i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

class PickupRules extends StatelessWidget {
  const PickupRules({Key? key}) : super(key: key);

  static void show() {
    Get.bottomSheet(
      const PickupRules(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          _buildHandleBar(),
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContent(),
                  SizedBox(height: 16.h),
                  _buildPriceTable(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      width: 40.w,
      height: 4.h,
      margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              LocaleKeys.pickup_rules_title.trans(),
              style: AppTypography.s18.bold.withColor(AppColors.neutral01),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.close,
              size: 24.sp,
              color: AppColors.neutral03,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.pickup_rules_desc_supported_products.trans(),
          style: AppTypography.s14.regular.withColor(AppColors.neutral01),
        ),
        SizedBox(height: 16.h),
        Text(
          LocaleKeys.pickup_rules_desc_fee_over_5m.trans(),
          style: AppTypography.s14.regular.withColor(AppColors.neutral01),
        ),
        SizedBox(height: 8.h),
        Text(
          LocaleKeys.pickup_rules_desc_fee_under_5m.trans(),
          style: AppTypography.s14.regular.withColor(AppColors.neutral01),
        ),
      ],
    );
  }

  Widget _buildPriceTable() {
    final priceData = [
      {'district': 'Lorem', 'price': '10'},
      {'district': 'Tân nghĩa', 'price': '10'},
      {'district': 'Lái thiêu', 'price': '100'},
      {'district': 'Dĩ An', 'price': '10'},
      {'district': 'An', 'price': '10'},
      {'district': 'Lorem', 'price': '10'},
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral06),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.neutral07,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    LocaleKeys.pickup_rules_table_location.trans(),
                    style:
                    AppTypography.s14.medium.withColor(AppColors.neutral01),
                  ),
                ),
                Expanded(
                  child: Text(
                    LocaleKeys.pickup_rules_table_fee_k.trans(),
                    style:
                    AppTypography.s14.medium.withColor(AppColors.neutral01),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          // Rows
          ...priceData.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == priceData.length - 1;

            return Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                border: isLast
                    ? null
                    : Border(
                  bottom: BorderSide(
                      color: AppColors.neutral06, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      item['district']!,
                      style: AppTypography.s14.regular
                          .withColor(AppColors.neutral01),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item['price']!,
                      style: AppTypography.s14.regular
                          .withColor(AppColors.neutral01),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      child: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary01,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 14.h),
        ),
        child: Text(
          LocaleKeys.pickup_rules_btn_evaluate_now.trans(),
          style: AppTypography.s16.medium.withColor(AppColors.white),
        ),
      ),
    );
  }
}
