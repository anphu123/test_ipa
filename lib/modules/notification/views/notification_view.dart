import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Thông báo',
          style: AppTypography.s16.regular.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildMailItem(
              onTap: () {
                Get.toNamed(Routes.notificationList);
              },
              iconAsset: Assets.images.icBell.path,
              title: 'Thông báo',
              subtitle: '🎉 Đại tiệc 06-06. SIÊU SALE SIÊU ĐÃ 👉 Xem ngay!',
              time: '1 phút trước',
            );
          } else if (index == 1) {
            return _buildMailItem(
              onTap: () {
                Get.toNamed(Routes.consignmentList);
              },
              iconAsset: Assets.images.icBoxtick.path,
              title: 'Ký gửi',
              subtitle: 'Hướng dẫn bạn kiếm tiền từ những món đồ cũ!',
              time: '30 phút trước',
            );
          } else {
            return _buildMailItem(
              iconAsset: Assets.images.icHeart.path,
              title: 'Mặt hàng đã lưu',
              subtitle: '🎁 [4 tin] | chưa đọc',
              time: '01/06/2025',
            );
          }
        },
      ),
    );
  }

  Widget _buildMailItem({
    required String iconAsset,
    required String title,
    required String subtitle,
    required String time,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Icon
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: AppColors.primary04,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  iconAsset,
                  width: 20.r,
                  height: 20.r,
                  color: AppColors.primary01,
                ),
              ),
            ),

            SizedBox(width: 12.w),

            /// Nội dung
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.s15.semibold),
                  SizedBox(height: 4.h),
                  Text(subtitle, style: AppTypography.s13.regular),
                  SizedBox(height: 2.h),
                  Text(
                    time,
                    style: AppTypography.s12.regular.copyWith(
                      color: AppColors.neutral04,
                    ),
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
