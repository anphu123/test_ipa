import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class RewardNotificationWidget extends StatelessWidget {
  const RewardNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.neutral06),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
             // color: AppColors.error,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Image.asset(Assets.images.icLixipurchase.path,fit: BoxFit.contain,)
          ),
          SizedBox(width: 12.w),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Báo cáo có thưởng',
                  style: AppTypography.s14.medium.copyWith(
                    color: AppColors.neutral01,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Nếu gặp trường hợp người thu gom giao dịch ri...',
                  style: AppTypography.s12.regular.copyWith(
                    color: AppColors.neutral03,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Arrow icon
          Icon(
            Icons.chevron_right,
            color: AppColors.neutral04,
            size: 20.r,
          ),
        ],
      ),
    );
  }
}
