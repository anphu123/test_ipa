import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PromotionBannerWidget extends StatelessWidget {
  const PromotionBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Chuẩn bị trước khi thu mua/ tái chế',
            style: AppTypography.s16.medium.copyWith(
              color: AppColors.neutral01,
            ),
          ),
          SizedBox(height: 12.h),

          // Banner Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              Assets.images.luuYOrderPurchase.path, // Thay bằng đường dẫn thực tế
              width: double.infinity,
              height: 80.h,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback container nếu không có image
                return Container(
                  width: double.infinity,
                  height: 80.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF6B46C1), // Purple
                        Color(0xFF3B82F6), // Blue
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      'NHỮNG LƯU Ý TRƯỚC KHI THU MUA',
                      style: AppTypography.s12.bold.copyWith(
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
