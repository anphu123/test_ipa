import 'package:fido_box_demo01/core/extensions/ml_extension.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/detail_product/controllers/detail_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fido_box_demo01/core/assets/assets.gen.dart';

import '../../../../core/assets/locale_keys.g.dart';

class ProductHeader extends GetView<DetailProductController> {
  const ProductHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.product.name.trML(),
          style: AppTypography.s16.semibold.withColor(AppColors.neutral01),
        ),
        SizedBox(height: 8.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _Tag(
                label: 'XiaoMi',
                icon: Image.asset(
                  Assets.images.logoXiaomi.path,
                  width: 16.w,
                  height: 16.w,
                ),
              ),
              SizedBox(width: 8.w),
              _Tag(
                label: LocaleKeys.integrated_ai.trans(),

                icon: Icon(Icons.auto_awesome, color: Colors.blue, size: 16),
              ),
              SizedBox(width: 8.w),
               _Tag(label:  LocaleKeys.best_selling_phone.trans(),),
              SizedBox(width: 8.w),
               _Tag(label:  LocaleKeys.other_phone.trans(),),
            ],
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({this.icon, required this.label});

  final Widget? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.neutral06),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, SizedBox(width: 4.w)],
          Text(
            label,
            style: AppTypography.s12.medium.withColor(AppColors.neutral01),
          ),
        ],
      ),
    );
  }
}
