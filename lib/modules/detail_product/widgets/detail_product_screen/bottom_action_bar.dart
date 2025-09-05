import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/locale_keys.g.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                final homeController = Get.find<HomeController>();
                homeController.requireLogin(() {
                  // TODO: Add to cart
                });
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary01),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: Text( LocaleKeys.add_to_cart.trans(),
                  style: AppTypography.s14.semibold.withColor(AppColors.primary01)),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                final homeController = Get.find<HomeController>();
                homeController.requireLogin(() {
                  // TODO: Buy now
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary01,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
              ),
              child: Text( LocaleKeys.buy_now.trans(),
                  style: AppTypography.s14.semibold.withColor(Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}