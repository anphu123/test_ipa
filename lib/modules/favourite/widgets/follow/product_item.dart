import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widget/currency_util.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/favourite_product_model.dart';

Widget buildProductItem(FavouriteProductModel item) {
  return Padding(
    padding: EdgeInsets.only(right: 8.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  image:
                      item.imageUrl.startsWith('http')
                          ? NetworkImage(item.imageUrl)
                          : AssetImage(item.imageUrl) as ImageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.neutral06,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    item.timeAgo,
                    style: AppTypography.s8.regular.withColor(
                      AppColors.neutral02,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          formatCurrency(item.price),
          style: AppTypography.s12.medium.withColor(AppColors.neutral01),
        ),
      ],
    ),
  );
}
