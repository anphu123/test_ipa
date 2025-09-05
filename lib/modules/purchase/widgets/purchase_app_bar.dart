import 'dart:io';

import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/purchase/widgets/show_help_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/purchase_controller.dart';

class PurchaseAppBar extends StatelessWidget {
  const PurchaseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200.h,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        GestureDetector(
          onTap: () => ShowHelpBottomSheet(context),
          child: Row(children: [Text("Trợ giúp"), SizedBox(width: 23.w)]),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(Assets.images.bgPurchase.path, fit: BoxFit.cover),
            Container(
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                bottom: 24.h,
                top: 16.h,
              ),
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 125.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "2Hand thua mua sản phẩm",
                      style: AppTypography.s16.regular.withColor(
                        AppColors.neutral02,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Mua bán nhanh chỉ bằng một cú nhấp chuột",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTypography.s24.bold.withColor(
                        AppColors.neutral01,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


