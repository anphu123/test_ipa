import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/about_2hand/controllers/about_2hand_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class About2HandView extends GetView<About2HandController> {
   About2HandView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          LocaleKeys.about_2hand.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
                SizedBox(height: 60),

            Image.asset(Assets.images.logoNew.path,width: 150.w,height: 150.h,),
             SizedBox(height: 16),

            // App name
            Text(
              '2Hand',
              style: AppTypography.s20.bold.withColor(AppColors.neutral01),
            ),

             SizedBox(height: 8),

            // Version
            Text(
              'v1.0.0.0.0.1',
              style: AppTypography.s14.regular.withColor(AppColors.neutral03),
            ),

             SizedBox(height: 60),

            // Update button
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary01),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  LocaleKeys.update_latest_version.trans(),
                  style: AppTypography.s16.medium.withColor(
                    AppColors.primary01,
                  ),
                ),
              ),
            ),

             SizedBox(height: 16),

            // Clear cache button
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.neutral04),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  LocaleKeys.clear_cache.trans(),
                  style: AppTypography.s16.medium.withColor(
                    AppColors.neutral01,
                  ),
                ),
              ),
            ),

             Spacer(),
          ],
        ),
      ),
    );
  }
}
