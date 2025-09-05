import 'package:fido_box_demo01/modules/favourite/widgets/follow/popular_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/mock_favourite_data.dart';

Widget buildPopularGroup() {
  return Container(
    width: 360.w,
    height: 200.h,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
    ),
    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    padding: EdgeInsets.all(12.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            children: [
              Container(
                //margin: EdgeInsets.only(left: 8.w),
                width: 40.r,
                height: 40.r,
                child: CircleAvatar(
                  radius: 12.r,
                  backgroundColor: Colors.grey.shade200,
                  // màu nền khi chưa load xong
                  backgroundImage:
                      (popularSuggestions.first.imgBrand.startsWith('http'))
                          ? NetworkImage(popularSuggestions.first.imgBrand)
                          : AssetImage(popularSuggestions.first.imgBrand)
                              as ImageProvider,
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 8.w),
              //   width: 50.r,
              //   height: 50.r,
              //   decoration: BoxDecoration(
              //     // color: AppColors.primary01,
              //     //    shape: BoxShape.circle,
              //     image: DecorationImage(
              //       image:
              //       popularSuggestions.first.imgBrand.startsWith('http')
              //           ? NetworkImage(popularSuggestions.first.imgBrand)
              //           : AssetImage(popularSuggestions.first.imgBrand) as ImageProvider,
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    popularSuggestions.first.category,
                    style: AppTypography.s16.medium.withColor(
                      AppColors.neutral01,
                    ),
                  ),
                  Text(
                    "MỚI!",
                    style: AppTypography.s12.medium.withColor(
                      AppColors.primary01,
                    ),
                  ),
                ],
              ),
              Spacer(),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary01),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size.zero,
                ),
                onPressed: () {
                  // TODO: xử lý khi bấm nút Follow
                },
                child: Row(
                  children: [
                    Icon(Icons.add, color: AppColors.primary01),
                    SizedBox(width: 4.w),
                    Text(
                      "Follow",
                      style: AppTypography.s12.withColor(AppColors.primary01),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: popularSuggestions.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (_, index) {
              return buildPopularItem(popularSuggestions[index]);
            },
          ),
        ),
      ],
    ),
  );
}
