import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/common_widget/currency_util.dart';
import '../../category_fido_purchase/domain/brand_mock_data.dart';
import '../../category_fido_purchase/widgets/product_model_view.dart';

class ExchangeOfferCard extends StatelessWidget {
  const ExchangeOfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: double.infinity,
      child: Row(
        children: [
          // Card trái: Ưu đãi
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: () => Get.to(BrandModelView(brand: brandApple)),

              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Container(
                  height: 120.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tiêu đề + badge
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              LocaleKeys.new_user_offer.trans(),
                              style: AppTypography.s12.bold.withColor(
                                AppColors.neutral01,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.AE02,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              LocaleKeys.temporary_increase.trans(),
                              style: AppTypography.s10.withColor(
                                AppColors.AE01,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      // Hàng chứa ảnh + thông tin sản phẩm
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ảnh
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Image.asset(
                                  Assets.images.pXiaomi15.path,
                                  width: 60.w,
                                  height: 60.w,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  //  height: 44.h,
                                  width: 44.h,
                                  //   color: AppColors.neutral07,
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                      color: AppColors.neutral07,
                                    ),
                                    color: AppColors.white,
                                  ),
                                  child: Text(
                                    LocaleKeys.last_time.trans(),
                                    style: AppTypography.s10.withColor(
                                      AppColors.neutral01,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w),

                          // Nội dung
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Xiaomi Pad 7',
                                      style: AppTypography.s14.regular
                                          .withColor(AppColors.neutral01),
                                    ),

                                    Text(
                                      LocaleKeys.change_machine.trans(),
                                      style: AppTypography.s12.regular
                                          .withColor(AppColors.neutral03),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.w),
                                //SizedBox(height: 6.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatCurrency(7990000),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // SizedBox(width: 8.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.primary01,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            LocaleKeys.change_now.trans(),
                                            style: AppTypography.s12.regular
                                                .withColor(AppColors.primary01),
                                          ),

                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16.sp,
                                            color: AppColors.primary01,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // Card phải: "Ở nhà có gì bán?"
          GestureDetector(
           onTap:()=> Get.toNamed(Routes.categoryFidoPurchase),

            child: Container(
              width: 100.w, // hoặc double.infinity tùy layout
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Container(
                width: 120.w, // Tuỳ chỉnh kích thước
                height: 130.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.transparent,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Ảnh nền
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        Assets.images.logoHome.path,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),

                    // Khối chứa văn bản "Ở nhà có gì bán?"
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.h,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.neutral07),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          LocaleKeys.what_for_sale.trans(),
                          style: AppTypography.s12.regular.withColor(
                            AppColors.neutral01,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
