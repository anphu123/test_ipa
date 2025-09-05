import 'package:fido_box_demo01/modules/consignment_list/controllers/consignment_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class ConsignmentListView extends GetView<ConsignmentListController> {
  const ConsignmentListView({super.key});

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
        itemCount: 2, // Sau này bạn có thể đổi sang controller.list.length
        itemBuilder: (context, index) {
          return buildConsignmentCard(
            title: '💡 Chỉ 1 phút! Hướng dẫn bạn kiếm tiền từ những món đồ cũ!',
            content:
                'Không cần đăng từng món, không cần trao đổi phức tạp với người mua, không lo lắng hậu mãi – chỉ cần 1 lần đặt lịch là có thể ký gửi đồng gói, nền tảng sẽ lo toàn bộ!',
            imageAsset: Assets.images.consignmentbanner.path,
          );
        },
      ),
    );
  }

  Widget buildConsignmentCard({
    required String title,
    required String content,
    String? imageAsset,
  }) {
    return Container(
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
          SizedBox(height: 12.h),

          /// Hình ảnh
          if (imageAsset != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                imageAsset,
                width: double.infinity,
                height: 140.h,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: 8.h),

          /// Ngày giờ
          Text(
            DateFormat('dd/MM/yyyy  HH:mm').format(DateTime.now()),
            style: AppTypography.s13.regular.copyWith(
              color: AppColors.neutral04,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),

          /// "Xem chi tiết"
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
    );
  }
}
