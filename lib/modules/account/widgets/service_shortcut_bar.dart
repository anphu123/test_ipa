import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../router/app_page.dart';

class ServiceShortcutBar extends StatelessWidget {
  const ServiceShortcutBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildServiceItem(
              Assets.images.icThumuatannoi.path,
              'Thu mua\n tận nơi',
            ),
          ),
          Expanded(
            child: _buildServiceItem(
              Assets.images.icDailydienthoai.path,
              'Đại lý\n điện thoại',
            ),
          ),
          Expanded(
            child: _buildServiceItem(
              Assets.images.icDichvudienthoai.path,
              'Dịch vụ\n gần bạn',
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.mailbox),
              child: _buildServiceItem(Assets.images.icCskh.path, 'CSKH'),
            ),
          ),
          Expanded(
            child: _buildServiceItem(
              Assets.images.icTrungamanninh.path,
              'Trung tâm\n an ninh',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String imagePath, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(imagePath, width: 24.w, height: 24.w, fit: BoxFit.contain),
        SizedBox(height: 6.h),
        SizedBox(
          width: 60.w,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.s11.withColor(AppColors.neutral01),
          ),
        ),
      ],
    );
  }
}
