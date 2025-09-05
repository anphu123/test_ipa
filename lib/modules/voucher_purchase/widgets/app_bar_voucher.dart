import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/voucher_purchase/widgets/view_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class AppBarVoucher extends StatelessWidget {
  const AppBarVoucher({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200.h,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        GestureDetector(
          onTap: () => Get.to(VoucherDetailView()),
          //     Get.snackbar(
          //   LocaleKeys.notification.trans(),
          //   LocaleKeys.feature_not_implemented.trans(),
          //   snackPosition: SnackPosition.TOP,
          // ),

          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.black,
                  size: 20,
                ),
                SizedBox(width: 8.w),
                Text("Xem chi tiết"),
              ],
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              Assets.images.bgVoucherPurchase1.path,
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                bottom: 24.h,
                top: 16.h,
              ),
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 125.h,
                    width: 161.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TRUNG TÂM\nVOUCHER",
                          style: AppTypography.s24.bold.withColor(
                            AppColors.neutral01,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Số lượng có hạn mỗi ngày!\nBao lì xì thu hồi có thể dùng kèm với phiếu tặng giá trị",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.s10.regular.withColor(
                            AppColors.neutral03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    Assets.images.centerVoucherPurchase.path,
                    height: 119.h,
                    width: 153.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}