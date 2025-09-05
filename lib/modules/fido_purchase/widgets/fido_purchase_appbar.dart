// fido_purchase_appbar.dart
import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/assets/assets.gen.dart';

class FidoPurchaseSliverAppBar extends StatelessWidget {
  const FidoPurchaseSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 150.h,
      backgroundColor: AppColors.primary01,
      automaticallyImplyLeading: false,
      title: _buildTitleBar(),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.r),
              ),
              child: Container(
                child: Image.asset(
                  Assets.images.bgThumua.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Bạn có thể thêm nội dung phía dưới ảnh tại đây nếu muốn
            Positioned(
              left: 16.w,
              bottom: 16.h,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: AppColors.white),
        ),
        SizedBox(width: 8.w),
        Text(
          LocaleKeys.twohand_purchase.trans(),
          style: AppTypography.s14.semibold.withColor(AppColors.white),
        ),
        SizedBox(width: 12.w),

        // Search box
        Expanded(
          child: Container(
            height: 36.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: GestureDetector(

              onTap: () {
                Get.snackbar(LocaleKeys.notification.trans(),
                  LocaleKeys.feature_not_implemented.trans(),
                  duration: Duration(seconds: 1),
                  snackPosition: SnackPosition.TOP,);
              },
              child: Row(
                children: [
                  Icon(Icons.search, size: 18.sp, color: Colors.grey),
                  SizedBox(width: 6.w),
                  Text(
                    LocaleKeys.search_placeholder.trans(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppTypography.s12.regular.withColor(Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),

        GestureDetector(
          onTap: () {
            Get.bottomSheet(
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            _buildBottomSheetItem(Icons.receipt_outlined,
                                'Đơn hàng\ncủa tôi'),
                            SizedBox(height: 8.h),
                            _buildBottomSheetItem(Icons.wallet_outlined,
                                'Quét'),
                          ],
                        ),
                        _buildBottomSheetItem(
                            Icons.folder_outlined, 'Hồ sơ\nkiểm định'),
                        _buildBottomSheetItem(
                            Icons.local_offer_outlined, 'Voucher'),
                        _buildBottomSheetItem(
                            Icons.headset_mic_outlined, LocaleKeys.customer_service.trans()),
                        _buildBottomSheetItem(
                            Icons.question_answer_outlined, 'Góp ý'),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        // height: 1.h,
                        height: 42.h,
                        //  color: AppColors.neutral03,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.neutral04,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            'Hủy bỏ',
                            style: AppTypography.s16.regular.withColor(
                                AppColors.neutral01),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
            );
          },
          child: Icon(
            Icons.more_vert_outlined,
            size: 22.sp,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

Widget _buildBottomSheetItem(IconData icon, String label) {
  return Column(
    //mainAxisSize: MainAxisSize.min,
    //crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(icon, size: 24.sp),
      SizedBox(height: 4.h),
      Text(
        label,
        textAlign: TextAlign.center,
        style: AppTypography.s12.regular,
      ),
    ],
  );
}