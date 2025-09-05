import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'build_featured_items.dart';
import 'fido_box_product_banner/auto_switch_featured_banner.dart';

class FidoBoxtab extends StatelessWidget {
  const FidoBoxtab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 12),

          // ← ✅ Thêm ở đây
          FeaturedItemsWidget(),
          //AutoSwitchFeaturedBanner(),
          // SizedBox(height: 12),
          //_buildBrandLogos(),
          //SizedBox(height: 12),
   //       _buildFilterBar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.snackbar(
                LocaleKeys.notification.trans(),
                LocaleKeys.feature_not_implemented.trans(),
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 2),
              );
            },
            child: Row(
              children: [
                Text(
                  '2Hand ',
               //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  style: AppTypography.s16.semibold.withColor(AppColors.neutral01),
                ),
                //icon:iIcons.arrow_forward,
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.snackbar(
                LocaleKeys.notification.trans(),
                LocaleKeys.feature_not_implemented.trans(),
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 2),
              );
            },
            child: Row(
              children: [
                Text(
                  'Bạn có sản phẩm muốn bán?',
                  //  style: TextStyle(fontSize: 14, color: Colors.blue),
                  // style: TextStyle(fontSize: 14, color: Colors.black),
                  style: AppTypography.s12.regular.withColor(
                    AppColors.neutral04,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                      LocaleKeys.notification.trans(),
                      LocaleKeys.feature_not_implemented.trans(),
                      snackPosition: SnackPosition.TOP,
                      duration: Duration(seconds: 2),
                    );
                  },
                  child: Text(
                    ' Đăng bán',
                    style: AppTypography.s12.bold.withColor(
                      AppColors.primary01,
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

  Widget _buildFilterBar() {
    final sortOptions = ['综合', '价格', '型号', '筛选'];
    final categories = ['YAMAHA', 'ROLEX', 'LV', 'iPhone', 'SONY',
      'Canon', 'Nintendo', 'Samsung', 'Gucci', 'Chanel'];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
          sortOptions.asMap().entries.map((entry) {
            int idx = entry.key;
            String option = entry.value;
            return GestureDetector(
              onTap: (){
                Get.snackbar(
                  LocaleKeys.notification.trans(),
                  LocaleKeys.feature_not_implemented.trans(),
                  snackPosition: SnackPosition.TOP,
                  duration: Duration(seconds: 2),
                );
              },
              child: Row(
                children: [
                  Text(
                    option,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight:
                      idx == 0 ? FontWeight.bold : FontWeight.normal,
                      color: idx == 0 ? Colors.amber : Colors.black,
                    ),
                  ),
                  Icon(
                    idx == 3 ? Icons.filter_list : Icons.arrow_drop_down,
                    size: 18.sp,
                    color: idx == 0 ? Colors.amber : Colors.black,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 12.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
            categories.map((category) {
              return Container(
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(category, style: TextStyle(fontSize: 12.sp)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
