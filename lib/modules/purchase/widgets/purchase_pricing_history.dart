import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/purchase_controller.dart';

Widget PurchaseHistory() {
  final controller = Get.find<PurchaseController>();
  final history = controller.pricingHistory;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Lịch sử định giá",
          style:
          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
      SizedBox(height: 8.h),
      Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Opacity(
              opacity: 0.3,
              child: Image.asset(
                history.image,
                width: 60.w,
                height: 60.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Opacity(
                opacity: 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(history.name,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4.h),
                    Text("₫${history.price}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    Text("Giảm giá (18%): ₫${history.discount}"),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Thu mua",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black)),
            ),
          ],
        ),
      ),
    ],
  );
}