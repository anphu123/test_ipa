import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/home_controller.dart';

class BannerSection extends GetView<HomeController> {
  const BannerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: 200.h,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.bannerImages.length,
              onPageChanged: controller.onPageChanged,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onPanDown: (_) => controller.pauseAutoScroll(),
                  onPanEnd: (_) => controller.resumeAutoScroll(),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        controller.bannerImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8.h),
          Obx(
                () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.bannerImages.length,
                    (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  width: controller.currentPage.value == index ? 20.w : 6.w,
                  height: 6.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: controller.currentPage.value == index
                        ? AppColors.primary01
                        : AppColors.primary03,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
