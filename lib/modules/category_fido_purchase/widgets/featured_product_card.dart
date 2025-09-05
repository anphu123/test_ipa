import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class FeaturedProductCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  const FeaturedProductCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 115.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.circular(10.r),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(imagePath, height: 40.h, width: 36.w, fit: BoxFit.contain),
          Text(name, style: AppTypography.s12.regular.withColor(AppColors.neutral01),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 1,),
          Text(price, style: AppTypography.s12.bold.withColor(AppColors.neutral01)),
        ],
      ),
    );
  }
}
