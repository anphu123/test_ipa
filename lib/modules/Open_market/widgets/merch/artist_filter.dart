import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/open_market_controller.dart';

class ArtistFilter extends StatelessWidget {
  const ArtistFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OpenMarketController>();

    return Obx(() {
      final artists = controller.allArtists;

      if (artists.isEmpty) return SizedBox.shrink();

      return SizedBox(
        height: 36.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: artists.length + 1,
          // +1 for "Tất cả"
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildFilterChip(
                label: 'Tất cả',
                isSelected: () => controller.selectedArtistId.value == '',
                onTap: controller.clearSelectedArtist,
              );
            }

            final artist = artists[index - 1];
            return _buildFilterChip(
              label: artist.name,
              isSelected: () => controller.selectedArtistId.value == artist.id,
              onTap: () => controller.selectArtist(artist),
            );
          },
        ),
      );
    });
  }

  Widget _buildFilterChip({
    required String label,
    required bool Function() isSelected,
    required VoidCallback onTap,
  }) {
    return Obx(() {
      final selected = isSelected();

      return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: selected ? AppColors.primary01 : AppColors.neutral07,
            border: Border.all(
              color: selected ? AppColors.primary01 : AppColors.neutral07,
              width: 1,
            ),
          ),
          child: Center(
            // Wrap the Text widget with Center
            child: Text(
              label,
              style: AppTypography.s14.regular.copyWith(
                color: selected ? Colors.white : AppColors.neutral04,
              ),
              textAlign: TextAlign.center, // Ensure text is centered
            ),
          ),
        ),
      );
    });
  }
}
