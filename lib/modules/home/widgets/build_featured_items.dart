import 'dart:ui';

import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/home/widgets/wave_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';

class FeaturedItemsWidget extends StatelessWidget {
  const FeaturedItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left large item
          Expanded(
            flex: 1,
            child: _buildFeaturedMainItem(
              context,
              title: 'Louis Vuitton MM',
              subtitle: '',
              price: '¥ 35600',
              imageUrl:
                  'https://www.charleskeith.vn/dw/image/v2/BCWJ_PRD/on/demandware.static/-/Sites-vn-products/default/dwce67f485/images/hi-res/2023-L7-CK2-50270880-1-28-1.jpg?sw=756&sh=1008',
              tag: '#潮流单品',
            ),
          ),
          SizedBox(width: 8.w),
          // Right column with two stacked items
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: _buildFeaturedItem(
                    context,
                    title: 'Xiaomi - Chiếc điện thoại thách thức thời gian',
                    subtitle: '',
                    price: '',
                    imageUrl:
                        'https://assets.nintendo.com/image/upload/ar_16:9,b_auto:border,c_lpad/b_white/f_auto/q_auto/dpr_auto/c_scale,w_300/v1/ncom/en_US/switch/site-design-update/hardware/switch/nintendo-switch-oled-model-white-set/gallery/image01?_a=AJADJWI0',
                    tag: '#游戏主机',
                  ),
                ),
                SizedBox(height: 8.w),
                Expanded(
                  child: GestureDetector(
                    child: _buildFeaturedItem(
                      context,
                      title: 'AirPods Max - Sống động từng thanh âm.',
                      subtitle: '',
                      price: '',
                      imageUrl:
                          'https://Open_market.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-14-pro-finish-select-202209-6-7inch-deeppurple?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1663703841896',
                      tag: '#热门手机',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedMainItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String price,
    required String imageUrl,
    required String tag,
  }) {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          LocaleKeys.notification.trans(),
          LocaleKeys.feature_not_implemented.trans(),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Stack(
          children: [
            // Background image
            Container(
              width: double.infinity,
              height: 250.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // // Glass wave background (from bottom to 20%)
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: ClipPath(
            //     clipper: WaveClipper(),
            //     child: BackdropFilter(
            //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            //       child: Container(
            //         height: 250.h * 0.3, // 20% of the image height
            //         color: Colors.red.withOpacity(0.5),
            //       ),
            //     ),
            //   ),
            // ),

            // Tag
            Positioned(
              bottom: 64.h, // Điều chỉnh khoảng cách tag với info box bên dưới
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: AppColors.primary01),
                ),
                child: Text(
                  tag,
                  style: AppTypography.s10.semibold.withColor(
                    AppColors.primary01,
                  ),
                ),
              ),
            ),

            // Bottom info box
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  children: [
                    // Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.r),
                      child: Image.network(
                        imageUrl,
                        width: 35.w,
                        height: 35.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.s10.semibold.withColor(
                              AppColors.neutral03,
                            ),
                          ),
                          if (subtitle.isNotEmpty)
                            Text(
                              subtitle,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.black54),
                            ),
                          if (price.isNotEmpty)
                            Text(
                              price,
                              style: AppTypography.s12.bold.withColor(
                                Colors.black,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String price,
    required String imageUrl,
    required String tag,
  }) {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          LocaleKeys.notification.trans(),
          LocaleKeys.feature_not_implemented.trans(),
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral07,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              width: 66.w,
              height: 66.w,
              margin: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        //horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      child: Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.s10.semibold.withColor(
                          AppColors.neutral04,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.primary01),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      tag,
                      style: AppTypography.s10.semibold.withColor(
                        AppColors.primary01,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
