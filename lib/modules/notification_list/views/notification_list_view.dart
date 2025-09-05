import 'package:fido_box_demo01/modules/notification_list/controllers/notification_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class NotificationListView extends GetView<NotificationListController> {
  NotificationListView({super.key});

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
  itemCount: 3, // Adjust this based on the number of notifications
  itemBuilder: (context, index) {
    if (index == 0) {
      return buildNotificationCard(
        title: '💥 Deal sốc cuối tuần!',
        content:
            'Đồng loạt giảm giá điện thoại, tai nghe lên đến 50%.\nÁp dụng từ Thứ Sáu đến Chủ nhật tuần này!',
      );
    } else if (index == 1) {
      return buildNotificationCard(
        title: '⚡ Flash Sale điện tử - 0h mỗi ngày!',
        content:
            'Hàng loạt sản phẩm công nghệ giảm giá chớp nhoáng. Giá tốt không kịp trở tay!',
      );
    } else {
      return buildNotificationCard(
        title: '🔥 Giảm giá siêu khủng - Chỉ hôm nay!',
        content:
            'Smartwatch, tai nghe, sạc dự phòng giảm đến 40%. Áp dụng trong 24h.',
      );
    }
  },
),
    );
  }

  Widget buildNotificationCard({
    required String title,
    required String content,

    // VoidCallback onTap,
  }) {
    return GestureDetector(
      // onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.neutral06, width: 0.5),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Tiêu đề
            Text(title, style: AppTypography.s15.bold),

            SizedBox(height: 8.h),

            /// Nội dung
            Text(
              content,
              style: AppTypography.s13.regular.copyWith(
                color: AppColors.neutral04,
                height: 1.4,
              ),
            ),
            Text(
              DateFormat(
                'dd/MM/yyyy'
                '  hh:mm',
              ).format(DateTime.now()),
              style: AppTypography.s13.regular.copyWith(
                color: AppColors.neutral04,
                height: 1.4,
              ),
            ),
            SizedBox(height: 12.h),

            /// "Xem chi tiết" + avatar (nếu có)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Xem chi tiết',
                  style: AppTypography.s13.bold.copyWith(
                    color: AppColors.primary01,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 16.sp,
                  color: AppColors.primary01,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
