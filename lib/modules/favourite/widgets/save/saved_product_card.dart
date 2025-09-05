import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/common_widget/currency_util.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/saved_product_model.dart';

class SavedProductCard extends StatelessWidget {
  final SavedProductModel product;

  const SavedProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình và thông tin
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  product.imageUrl,
                  width: 100.w,
                  height: 100.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildChip(
                          "C",
                          style: AppTypography.s9.bold.withColor(
                            AppColors.white,
                          ),
                          color: AppColors.AS01,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          product.conditionLabel + " " + product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTypography.s14.medium
                                ..withColor(AppColors.neutral01),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 2.w,
                      runSpacing: 2.h,
                      children: [
                        _buildTag(product.screenStatus),
                        _buildTag(product.scratchStatus),
                        _buildTag(product.scratchStatus),
                        _buildTag("..."),
                      ],
                    ),

                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.emoji_events,
                          size: 14.sp,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 4.w),
                        Text(product.tag, style: TextStyle(fontSize: 10.sp)),
                        SizedBox(width: 4.w),
                        Icon(Icons.arrow_forward_ios, size: 10.sp,color:AppColors.neutral02 ,),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Giá tiền
                        Text(
                          formatCurrency(product.price),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Avatar + tên người bán
                        Row(
                          children: [
                            Container(
                              width: 20.w,
                              height: 20
                                  .w,
                              child: CircleAvatar(
                                radius: 12.r,
                                backgroundImage: NetworkImage(
                                  product.sellerAvatar,
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w), // 👈 Sửa lại spacing ngang
                            // Giới hạn độ rộng tên
                            SizedBox(
                              width: 70.w,
                              child: Text(
                                product.sellerName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.s12.regular.withColor(
                                  AppColors.neutral02,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Giảm " + formatCurrency(product.price),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primary01,
                          ),
                        ),

                        // Avatar seller
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
            ],
          ),

          SizedBox(height: 12.h),

          // Nút hành động
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _buildButton("So sánh giá", outlined: true)),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildButton(
                  product.isOutOfStock
                      ? "Tìm sản phẩm tương tự"
                      : "Đổi cũ lấy mới",
                  outlined: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, {Color? color, TextStyle? style}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(label, style: style),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      //      padding: EdgeInsets.all(2.w),
      //margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        //   color: AppColors.AW02,
        border: Border.all(color: AppColors.neutral04),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: AppTypography.s8.regular.withColor(AppColors.neutral03),
      ),
    );
  }

  Widget _buildButton(String label, {required bool outlined}) {
    return Container(
      width: 122.w,
      height: 36.h,
      child: OutlinedButton(
        onPressed: () {
          Get.snackbar(
            LocaleKeys.notification.trans(),
            LocaleKeys.feature_not_implemented.trans(),
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 2),
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: outlined ? AppColors.white : AppColors.primary01,
          side: BorderSide(color: AppColors.primary01),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          //padding: EdgeInsets.symmetric(vertical: 8.h),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            color: outlined ? AppColors.primary01 : Colors.white,
          ),
        ),
      ),
    );
  }
}
