import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';
import 'category_group_card.dart';
Widget menubar() {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.neutral08,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        CategoryGroupCard(
          backgroundItem: AppColors.primary04,
          title: "Thiết bị điện tử",
          borderRadiusItem: BorderRadius.only(topRight:Radius.circular(12.r)),
          gradientStart: const Color(0xFFFBB379),
          gradientEnd: const Color(0xFFFE675C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            // topRight: Radius.circular(12.r),
          ),
          items: [
            {'label': LocaleKeys.phone_category.trans(), 'image': Assets.images.ctDienthoai.path,id : 0},
            {'label': LocaleKeys.tablet_category.trans(), 'image': Assets.images.ctTablet.path ,id: 1},
            {'label': LocaleKeys.laptop_category.trans(), 'image': Assets.images.ctLaptop.path,id: 2},
            {'label': LocaleKeys.clock.trans(), 'image': Assets.images.ctDongho.path,id: 3},
            {'label': LocaleKeys.game_machine.trans(), 'image': Assets.images.ctMaychoigame.path,id: 4},
            {'label': LocaleKeys.pc.trans(), 'image': Assets.images.ctPc.path,id: 5},
            {'label': LocaleKeys.camera.trans(), 'image': Assets.images.ctMayanh.path,id: 6},
            {'label': LocaleKeys.flycam.trans(), 'image': Assets.images.ctFlycam.path,id: 7},
          ],
          onItemTap: (id) => Get.toNamed(Routes.categoryFidoPurchase, arguments: {'id': id}),
        ),
        Divider(height: 1, color: Colors.grey.shade300),
        CategoryGroupCard(
          backgroundItem: AppColors.AB02,
          title: "Đời sống",
          gradientStart: Color(0xFF329CFE),
          gradientEnd: Color(0xFF8DD5FF),
          items: [
            {'label': LocaleKeys.household_appliances.trans(), 'image': Assets.images.ctGiadung.path,id: 8},
            {'label': LocaleKeys.sports_outdoors.trans(), 'image': Assets.images.ctThethao.path,id: 9},
            {'label': LocaleKeys.musical_instrument.trans(), 'image': Assets.images.ctNhacu.path,id: 10},
            {'label': LocaleKeys.pets.trans(), 'image': Assets.images.ctThucung.path,id: 11},
          ],
          onItemTap: (id) => Get.toNamed(Routes.categoryFidoPurchase, arguments: {'id': id}),
        ),
        Divider(height: 1, color: Colors.grey.shade300),
        CategoryGroupCard(
          title: "Sản phẩm cao cấp",
          backgroundItem: AppColors.secondaryP04,
          borderRadiusItem: BorderRadius.only(bottomRight  :Radius.circular(12.r)),
          gradientStart: const Color(0xFF6167EF),
          gradientEnd: const Color(0xFFA0AFFE),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.r),
            // topRight: Radius.circular(12.r),
          ),
          items: [
            {'label': LocaleKeys.hand_bag.trans(), 'image': Assets.images.ctTuixach.path,id: 12},
            {'label': LocaleKeys.jewelry.trans(), 'image': Assets.images.ctTrangsuc.path,id: 13},
            {'label': LocaleKeys.shoes_sandals.trans(), 'image': Assets.images.ctGiaydep.path,id: 14},
            {'label': LocaleKeys.clock.trans(), 'image': Assets.images.ctDongho.path,id: 15},
          ],
          onItemTap: (id) => Get.toNamed(Routes.categoryFidoPurchase, arguments: {'id': id}),
        ),
        GestureDetector(
          onTap: (){
            Get.toNamed(Routes.categoryFidoPurchase);
          },
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.neutral08,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            //padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row  (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocaleKeys.other_categories.trans()),
                SizedBox(width: 6.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14.sp,
                  color: AppColors.neutral01,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}