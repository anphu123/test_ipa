import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/favourite/controllers/followed_tab_controller.dart';
import 'package:fido_box_demo01/modules/favourite/widgets/follow/product_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../router/app_page.dart';

Widget buildProductGroup(String category) {
  final controller = Get.find<FollowedTabController>();
  final products =
      controller.products.where((e) => e.category == category).toList();

  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16.r),
    ),
    // padding: EdgeInsets.all(16.w),
    //   margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    child: GestureDetector(
     onTap: ()=> Get.toNamed(Routes.brandStore),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                //   margin: EdgeInsets.only(left: 8.w),
                width: 40.r,
                height: 40.r,
                child: CircleAvatar(
                  radius: 12.r,
                  backgroundColor: Colors.grey.shade200,
                  // màu nền khi chưa load xong
                  backgroundImage:
                      (products.first.imgBrand.startsWith('http'))
                          ? NetworkImage(products.first.imgBrand)
                          : AssetImage(products.first.imgBrand) as ImageProvider,
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 8.w),
              //   width: 30.r,
              //   height: 30.r,
              //   decoration: BoxDecoration(
              // // color: AppColors.primary01,
              //     //    shape: BoxShape.circle,
              //     image: DecorationImage(
              //       image: AssetImage(products.first.imgBrand),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: AppTypography.s16.medium.withColor(
                      AppColors.neutral01,
                    ),
                  ),
                  Text(
                    "MỚI!",
                    style: AppTypography.s14.bold.withColor(AppColors.primary01),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                 Routes.brandStore;
                },
                child: Row(
                  children: [
                    Text(
                      LocaleKeys.view_detail.trans(),
                      style: AppTypography.s12.medium.withColor(
                        AppColors.neutral02,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.w,
                      color: AppColors.neutral02,
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 141.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (_, index) => buildProductItem(products[index]),
            ),
          ),
        ],
      ),
    ),
  );
}
