import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/open_market_controller.dart';

class ArtistListView extends StatelessWidget {
  final OpenMarketController controller = Get.put(OpenMarketController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.allArtists.length,
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            final artist = controller.allArtists[index];

            return Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: 82.w,
                      height: 82.w,
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: Image.network(
                          artist.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) => Icon(Icons.error, size: 20.sp),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.h,
                      child: GestureDetector(
                        onTap: () => controller.toggleFollow(index),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 80.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary01,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: FittedBox(
                              child: Text(
                                artist.isFollowing
                                    ? 'Đang theo dõi'
                                    : '+ Theo dõi',
                                style: AppTypography.s12.semibold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  artist.name,
                  style: AppTypography.s12.semibold.withColor(
                    AppColors.neutral02,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
