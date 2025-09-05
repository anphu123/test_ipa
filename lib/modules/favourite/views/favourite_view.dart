import 'package:fido_box_demo01/modules/favourite/controllers/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../widgets/follow/build_following.dart';
import '../widgets/history/buid_history.dart';
import '../widgets/save/build_save.dart';

class FavouriteView extends GetView<FavouriteController> {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent, // ✅ Ngăn đổi màu khi scroll
        elevation: 0.5, // ✅ Có đường phân cách nhẹ
        toolbarHeight: 56.h,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              _buildTabButton('Đang theo dõi', 0),
              SizedBox(width: 12.w),
              _buildTabButton('Đã lưu', 1),
              SizedBox(width: 12.w),
              _buildTabButton('Lịch sử', 2),
              // Add more tabs here if needed
            ],
          ),
        ),
      ),
      body: Obx(() {
        switch (controller.currentTab.value) {
          case 0:
            return FollowedTab();
          case 1:
            return SavedProductView();
          case 2:
            return HistoryViewedScreen();
          default:
            return SizedBox.shrink();
        }
      }),
    );
  }


  // ---------------- Tab Buttons ----------------

  Widget _buildTabButton(String title, int index) {
    return Obx(() {
      final isSelected = controller.currentTab.value == index;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: InkWell(
          onTap: () => controller.changeTab(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTypography.s14.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primary01 : AppColors.neutral04,
                ),
              ),
              SizedBox(height: 4.h),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2.h,
                width: 24.w,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary01 : Colors.transparent,
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // ---------------- Tab Content ----------------

  Widget _buildSavedTab() {
    return Center(child: Text('⭐ Sản phẩm bạn đã lưu'));
  }

  Widget _buildHistoryTab() {
    return Center(child: Text('🕘 Lịch sử sản phẩm đã xem'));
  }
}
