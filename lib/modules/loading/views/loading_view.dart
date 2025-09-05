import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/loading/controllers/loading_controller.dart';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';

class LoadingScreen extends GetView<LoadingController> {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   backgroundColor: AppColors.white,
      //   elevation: 0,
      //
      //   title: Image.asset(Assets.images.logoNew.path, height: 50.h),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.images.logoNew.path,
                fit: BoxFit.cover,
                width: 150.w,
                height: 150.h,
              ),
              Text(
              LocaleKeys.welcome.trans(),
                textAlign: TextAlign.center,
                style: AppTypography.s20.bold.withColor(AppColors.neutral01),
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTypography.s12.regular.copyWith(
                      color: AppColors.neutral04,
                      height: 1.5, // tăng giãn dòng
                    ),
                    children: [
                       TextSpan(text: LocaleKeys.loading_text1.trans(),),
                      TextSpan(
                        text:LocaleKeys.loading_text2.trans(),
                        style: AppTypography.s12.regular.copyWith(
                          color: AppColors.primary01,
                        ),
                      ),
                       TextSpan(text: LocaleKeys.loading_text3.trans(),),
                      // const TextSpan(
                      //   text:
                      //   "Hay bạn muốn tìm những món đồ độc đáo với mức giá phải chăng? ",
                      // ),
                      TextSpan(
                        text: LocaleKeys.loading_text4.trans(),
                        style: AppTypography.s14.regular.copyWith(
                          color: AppColors.primary01,
                        ),
                      ),
                       TextSpan(text: LocaleKeys.loading_text5.trans(),),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
