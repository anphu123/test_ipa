import 'dart:async';

import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/voucher_purchase/widgets/hub_coupon/voucher_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'collect_button.dart';

Widget BuildVoucherWarehouseSection() {
  final vouchers = [
    {'amount': '50k', 'condition': 'Đơn tối thiểu đ500.000'},
    {'amount': '100k', 'condition': 'Đơn tối thiểu đ2.000.000'},
    {'amount': '250k', 'condition': 'Đơn tối thiểu đ5.000.000'},
    {'amount': '500k', 'condition': 'Đơn tối thiểu đ8.000.000'},
  ];

  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12.r),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black.withOpacity(0.1),
      //     blurRadius: 8,
      //     offset: Offset(0, 2),
      //   ),
      // ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Icon(Icons.card_giftcard, color: Colors.red),
            Container(
              height: 24.h,
              width: 24.w,
              child: Image.asset(Assets.images.icBaolixi.path,fit: BoxFit.fill,),
            ),
            SizedBox(width: 6),
            Text("Kho voucher", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        //    SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          // Ensures the grid takes only the required space
          physics: const NeverScrollableScrollPhysics(),
          // Disables scrolling inside the grid
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10.w, // Horizontal spacing
            mainAxisSpacing: 1.h, // Vertical spacing
            childAspectRatio: 2, // Aspect ratio for grid items
          ),
          itemCount: vouchers.length,
          // Number of items
          itemBuilder: (context, index) {
            final item = vouchers[index];
            return VoucherCard(
              value: item['amount']!,
              condition: item['condition']!,
            );
          },
        ),
        SizedBox(height: 16.h),
        CollectButton(),
      ],
    ),
  );
}
