import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fido_box_demo01/core/assets/assets.gen.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'collect_button.dart';

Widget BuildVoucherTaskSection() {
  final List<Map<String, String>> vouchers = [
    {
      'amount': '500k',
      'condition': 'Đơn từ 500.000',
      'des': "Số lượng có hạn",
      'label': 'Ưu đãi tốt nhất',
    },
    {
      'amount': '1tr',
      'des': "Số lượng có hạn",
      'condition': 'Đơn từ 1.000.000',
      'label': 'Ưu đãi tốt nhất',
    },
  ];

  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black.withOpacity(0.08),
      //     blurRadius: 6,
      //     offset: Offset(0, 2),
      //   ),
      // ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 24.h,
                  width: 24.w,
                  child: Image.asset(
                    Assets.images.icBaolixi.path,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "Làm nhiệm vụ \nđể nhận voucher",
                  style: AppTypography.s16.bold,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.primary01,
                borderRadius: BorderRadius.circular(8.r),
              ),
              //  child: Image.asset(Assets.images.icVoucherTask.path,fit: BoxFit.fill,),
              child: Center(
                child: Text(
                  "Xem ngay",
                  style: AppTypography.s16.regular.withColor(AppColors.white),
                ),
              ),
            ),
          ],
        ),
        //SizedBox(height: 12.h),

        // Voucher grid
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: vouchers.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 1.h,
            childAspectRatio: 1.6, // 👈 GIẢM để tăng chiều cao
          ),
          itemBuilder: (context, index) {
            final voucher = vouchers[index];

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 130.h,
                  // tăng thêm chiều cao
                  width: 160.w,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    //color: AppColors.primary01,
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: AssetImage(Assets.images.coucherItemTask.path),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        voucher['amount'] ?? '',
                        style: AppTypography.s20.bold.withColor(
                          AppColors.primary01,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        height: 28.h,
                        width: 1.5.w,
                        color: AppColors.primary03,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              voucher['condition'] ?? '',
                              style: AppTypography.s10.regular.withColor(
                                AppColors.primary01,
                              ),
                            ),
                            //  SizedBox(height: 4.h),
                            //   Text(
                            //     voucher['des'] ?? '',
                            //     style: AppTypography.s10.regular.withColor(AppColors.primary01),
                            //   ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Label giữ nguyên
                if (voucher['label'] != null)
                  Positioned(
                    top: 10.h,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),

                      child: Text(
                        voucher['label']!,
                        style: AppTypography.s10.medium.withColor(
                          AppColors.AW01,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),

        SizedBox(height: 16.h),
        CollectButton(),
      ],
    ),
  );
}
