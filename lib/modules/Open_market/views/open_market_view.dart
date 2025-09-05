import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../router/app_page.dart';
import '../controllers/open_market_controller.dart';
import '../widgets/highlighted_filter/highlighted_filter_view.dart';
import '../widgets/merch/merch_view.dart';

class OpenMarketView extends GetView<OpenMarketController> {
  OpenMarketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        titleSpacing: 0,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                _buildTabButton('Nổi bật', 0),
                _buildTabButton('Merch', 1),
                _buildTabButton('Vị trí', 2),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            if (controller.currentTab.value == 0) {
              return IconButton(
                icon:  Icon(Icons.filter_list, color: Colors.grey),
                onPressed: () {
                  // TODO: Filter for "Nổi bật"
                },
              );
            } else {
              return IconButton(
                icon:  Icon(Icons.search, color: Colors.grey),
                onPressed: () {
                  // TODO: Filter for "Nổi bật"
                },
              ); // hoặc null nếu không muốn hiện gì
            }
          }),
          _IconBox(
            assetPath: Assets.images.icMessage.path,
            onTap: () {
              Get.toNamed(Routes.mailbox);
            },
          ),
        ],

      ),
      body: Obx(() {
        return IndexedStack(
          index: controller.currentTab.value,
          children: const [
            HighlightedFilterView(),
            MerchView(),
            Center(child: Text('📍 Tìm theo vị trí')),
          ],
        );
      }),
    );
  }

  // ---------------- Tab Buttons ----------------

  Widget _buildTabButton(String title, int index) {
    return Obx(() {
      final isSelected = controller.currentTab.value == index;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: GestureDetector(
          onTap: () => controller.changeTab(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTypography.s16.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color:
                  isSelected ? AppColors.primary01 : AppColors.neutral04,
                ),
              ),
              SizedBox(height: 4.h),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2.h,
                width: 24.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary01
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

// ---------------- IconBox Widget ----------------

class _IconBox extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;

  const _IconBox({
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: SizedBox(
        width: 32.w,
        height: 32.w,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.all(6.r),
              child: Image.asset(
                assetPath,
                width: 20.w,
                height: 20.h,
                color: AppColors.primary01,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
