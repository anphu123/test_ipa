import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';

class PurchaseSellBar extends StatelessWidget {
  const PurchaseSellBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// PHẦN MUA BÁN
          Row(
            children: [
              /// MUA HÀNG
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mua hàng', style: AppTypography.s14.bold),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildItem(
                            Assets.images.icChothanhtoan.path,
                            'Chờ thanh toán',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildItem(
                            Assets.images.icDanggiaohang.path,
                            'Đang chờ ngiao hàng',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildItem(
                            Assets.images.icHoantien.path,
                            'Hoàn tiền',
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),

              /// DIVIDER
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                height: 40.h,
                width: 1.w,
                color: AppColors.neutral05,
              ),

              /// BÁN HÀNG
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bán hàng', style: AppTypography.s14.bold),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildItem(
                            Assets.images.icChothanhtoan1.path,
                            'Bài đăng',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildItem(
                            Assets.images.icDanhgia.path,
                            'Đánh giá',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// BẢN NHÁP (DƯỚI ROW)
          SizedBox(height: 16.h),
          _buildDraftBox(),
        ],
      ),
    );
  }

  /// Widget nút "Bản nháp"
  Widget _buildDraftBox() {
    return InkWell(
      onTap: () {
        Get.snackbar(
          LocaleKeys.notification.trans(),
          LocaleKeys.feature_not_implemented.trans(),
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.TOP,
        );
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.neutral08,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            // Icon(Icons.book_online_rounded, size: 20.sp, color: AppColors.neutral03),
            Image.asset(Assets.images.icBannhap.path),
            SizedBox(width: 8.w),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bản nháp",
                    style: AppTypography.s12.bold.withColor(
                      AppColors.neutral02,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      "3 giây để hoàn thiện bản nháp và xuất bản ngay lập tức...",
                      style: AppTypography.s12.regular.withColor(
                        AppColors.neutral04,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: AppColors.neutral03,
            ),
          ],
        ),
      ),
    );
  }

  /// Widget item mua/bán hàng
  Widget _buildItem(String imagePath, String label) {
    return SizedBox(
      width: 60.w,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 24.w,
            height: 24.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: AppTypography.s11.withColor(AppColors.neutral01),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
