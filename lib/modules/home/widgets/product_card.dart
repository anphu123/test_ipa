import 'package:fido_box_demo01/core/extensions/ml_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/modules/home/controllers/home_controller.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/common_widget/currency_util.dart';
import '../domain/model/category_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double cardWidth = 176.w;
    final double cardHeight = 282.h;
    final double imageHeight = cardWidth * 0.68;
    final controller = Get.find<HomeController>();

    return GestureDetector(
      onTap: () => controller.goToProductDetail(product.id),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              //  color: Colors.grey.withOpacity(0.5),
              //    color: AppColors.primary01.withOpacity(0.1),
              color: AppColors.neutral07,
              blurRadius: 5,
              offset: Offset(0, 2), // Đổ bóng nhẹ phía dưới
            ),
          ],
          //  border: Border.all(color: AppColors.primary04, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 100.w),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: Image.network(
                    product.imgUrlp,
                    width: double.infinity,
                    height: imageHeight,
                    fit: BoxFit.scaleDown,
                    errorBuilder:
                        (_, __, ___) => Container(
                          height: imageHeight,
                          color: Colors.grey[200],
                          child: Icon(Icons.broken_image, size: 40.sp),
                        ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryP05,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              // LocaleKeys.verify.trans(),
                              "95%",
                              style: AppTypography.s9.bold.withColor(
                                AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary01,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              // LocaleKeys.verify.trans(),
                              "S",
                              style: AppTypography.s9.bold.withColor(
                                AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            //    color: AppColors.strokeKiemDinh,
                            color: AppColors.AW02,
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              Assets.images.icKiemdinh.path,
                              width: 8.w,
                              height: 8.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              LocaleKeys.verify.trans(),
                              style: AppTypography.s9.medium.withColor(
                                AppColors.AW01,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name.trML(),

                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    //    SizedBox(height: 12.h),

                    //const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatCurrency(product.price),
                              style: AppTypography.s10.bold.copyWith(
                                color: AppColors.neutral05,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppColors.neutral05,
                                // Add this line to set the color of the line-through
                                decorationThickness: 1.5,
                              ),
                            ),

                            Text(
                              formatCurrency(product.price),

                              style: AppTypography.s15.bold.withColor(
                                //  AppColors.primary01,
                                AppColors.neutral01,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary01,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Image.asset(
                            Assets.images.icBag.path,
                            width: 16.w,
                            height: 16.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      width: 160.w,
                      height: 23.w,
                      decoration: BoxDecoration(
                        //   color: AppColors.primary01.withOpacity(0.1),
                        color: AppColors.primary04,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Xem sản phẩm",
                            style: AppTypography.s10.regular.withColor(
                              AppColors.primary01,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 18.sp,
                            color: AppColors.primary01,
                          ),
                        ],
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
