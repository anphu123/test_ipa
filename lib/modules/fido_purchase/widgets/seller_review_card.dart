import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/assets/assets.gen.dart';
import '../controllers/seller_review_page_controller.dart';
import '../domain/seller_review_model.dart';

class SellerReviewCard extends GetView<SellerReviewPageController> {
  const SellerReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Đảm bảo có controller nếu page cha chưa bind
    if (!Get.isRegistered<SellerReviewPageController>()) {
      Get.put(SellerReviewPageController());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabBar(),
        SizedBox(height: 20.h),
        Obx(() {
          final list = controller.reviews;
          if (list.isEmpty) {
            return Center(
              child: SizedBox(
                height: 50.h,
                child: const Text("Không có đánh giá nào"),
              ),
            );
          }
          return Column(
            children: list.map((review) => _buildReviewItem(review)).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildTabBar() {
    return Obx(
          () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(controller.tabs.length, (index) {
            final selected = controller.selectedIndex.value == index;
            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: _buildTab(controller.tabs[index], selected),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTab(String label, bool selected) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary01 : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          label,
          style: AppTypography.s16.regular.copyWith(
            color: selected ? AppColors.white : AppColors.neutral01,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewItem(SellerReview review) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.r)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(review.avatar),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.userName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            review.location,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("Đã bán được ", style: TextStyle(fontSize: 12.sp)),
                    Text(
                      review.soldAmount,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(review.comment, style: TextStyle(fontSize: 13.sp)),
                SizedBox(height: 8.h),
                if (review.tags.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: review.tags
                          .map(
                            (tag) => Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: _buildChip(tag),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                SizedBox(height: 12.h),
                _buildProductBox(review),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.grey.shade200,
      ),
      child: Text(tag, style: TextStyle(fontSize: 12.sp)),
    );
  }

  Widget _buildProductBox(SellerReview review) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (review.isVerified) ...[
                Image.asset(Assets.images.icVerified.path, width: 16.w),
                SizedBox(width: 4.w),
                Text(
                  "Đã kiểm định",
                  style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                ),
              ],
              const Spacer(),
              Text(
                review.productName,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          if (review.productImages.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: review.productImages.map((img) {
                  return Padding(
                    padding: EdgeInsets.only(right: 6.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        img,
                        width: 60.w,
                        height: 60.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
