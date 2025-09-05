import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

// i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

class ShippingContentWidget extends StatelessWidget {
  const ShippingContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.shipping_guide_title.trans(),
            style: AppTypography.s14.medium,
          ),
          SizedBox(height: 8.h),
          Text(
            '• ${LocaleKeys.shipping_guide_item_1.trans()}\n'
                '• ${LocaleKeys.shipping_guide_item_2.trans()}\n'
                '• ${LocaleKeys.shipping_guide_item_3.trans()}',
            style: AppTypography.s12.regular.copyWith(
              color: AppColors.neutral03,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primary01.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              LocaleKeys.shipping_guide_note.trans(),
              style: AppTypography.s12.medium.copyWith(
                color: AppColors.primary01,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
