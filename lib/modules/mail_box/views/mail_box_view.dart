import 'package:fido_box_demo01/core/assets/assets.gen.dart';
import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/mail_box_controller.dart';
import '../widgets/customer_servicel_sheet.dart';

class MailBoxView extends GetView<MailBoxController> {
  const MailBoxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
        //   onPressed: () => Get.back(),
        // ),
        title:  Text(LocaleKeys.mail_box.trans()),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFollowBanner(),
            SizedBox(height: 16.h),

            // Item: CSKH
            GestureDetector(
              onTap: _showCskhBottomSheet,
              child: _buildMessageItem(
                imageAsset: Assets.images.icCustomer.path,
                title: '${LocaleKeys.customer_service.trans()} 2Hand',
                subtitle: 'Xem chi tiết',
                time: '30 phút trước',
                isUnread: false,
              ),
            ),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.notification),
          child: _buildMessageItem(
            imageAsset: Assets.images.icBell.path,
            title: LocaleKeys.notification.trans(),
            subtitle: '[99+ tin] chưa đọc',
            time: DateFormat('dd/MM/yyyy').format(DateTime.now()),
            isUnread: true,
          ),
        ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowBanner() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: AppColors.AW02,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.AW01, size: 20.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: SizedBox(
                height: 20.h,
                child: Marquee(
                  text: 'Nhấn theo dõi để cập nhật tin tức mỗi ngày!',
                  style: AppTypography.s12.regular.withColor(AppColors.AW01),
                  velocity: 30.0,
                  blankSpace: 40.0,
                  startPadding: 10.0,
                  pauseAfterRound: Duration(seconds: 1),
                  fadingEdgeStartFraction: 0.1,
                  fadingEdgeEndFraction: 0.1,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Row(
              children: [
                Text(
                  'Theo dõi',
                  style: AppTypography.s12.bold.withColor(AppColors.AW01),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColors.AW01,
                  size: 16.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem({
    required String imageAsset,
    required String title,
    required String subtitle,
    required String time,
    required bool isUnread,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      minLeadingWidth: 40.w,
      leading: Container(
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          color: AppColors.primary01.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(
            imageAsset,
            width: 20.r,
            height: 20.r,
            color: AppColors.primary01,
          ),
        ),
      ),
      title: Text(title, style: AppTypography.s15.semibold),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: AppTypography.s13.regular.copyWith(
              color: isUnread ? Colors.redAccent : AppColors.neutral04,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            time,
            style: AppTypography.s12.regular.copyWith(
              color: AppColors.neutral04,
            ),
          ),
        ],
      ),
    );
  }

  void _showCskhBottomSheet() {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.66, // 65% chiều cao
        child: const CustomerServiceSheet(),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
