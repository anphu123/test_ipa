  import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/Open_market/domain/model/mock_artistmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/model/artist_model.dart';

class VerifiedMarketView extends StatelessWidget {
  VerifiedMarketView({super.key});

  final PageController _pageController = PageController(viewportFraction: 1.0);
  final RxInt currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    final int itemsPerPage = 4;
    final int pageCount = (mockArtists.length / itemsPerPage).ceil();

    final List<List<ArtistModel>> pages = List.generate(
      pageCount,
          (index) =>
          mockArtists.skip(index * itemsPerPage).take(itemsPerPage).toList(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Chợ tự do",
                    style: AppTypography.s16.medium.withColor(AppColors.neutral02),
                  ),
                  SizedBox(width: 6.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.AB01.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.images.icVerified.path,
                          width: 14.w,
                          height: 16.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "Đã xác minh danh tính",
                          style: AppTypography.s14.bold.withColor(AppColors.AB01),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.snackbar(
                    LocaleKeys.notification.trans(),
                    LocaleKeys.feature_not_implemented.trans(),
                    snackPosition: SnackPosition.TOP,
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "Xem tất cả",
                      style: AppTypography.s12.medium.withColor(AppColors.neutral02),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 14.sp,
                      color: AppColors.neutral02,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        // Paging Content
        Column(
          children: [
            ClipRect(
              child: SizedBox(
                height: 140.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) => currentPage.value = index,
                  itemBuilder: (context, pageIndex) {
                    final pageItems = pages[pageIndex];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: GridView.builder(
                        itemCount: pageItems.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.h,
                          crossAxisSpacing: 8.w,
                          childAspectRatio: 3.1,
                        ),
                        itemBuilder: (context, index) {
                          final item = pageItems[index];
                          return _buildGroupItem(item);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

           // SizedBox(height: 5.h),

            Obx(
                  () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    width: currentPage.value == index ? 20.w : 6.w,
                    height: 6.h,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: currentPage.value == index
                          ? AppColors.primary01
                          : AppColors.primary03,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildGroupItem(ArtistModel item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w), // Đồng bộ với layout
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: Image.network(
              item.imageUrl,
              width: 40.w,
              height: 40.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.s14.semibold.withColor(AppColors.neutral02),
                ),
                Text(
                  "${item.productCount} Sản phẩm",
                  style: AppTypography.s10.regular.withColor(AppColors.neutral03),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
