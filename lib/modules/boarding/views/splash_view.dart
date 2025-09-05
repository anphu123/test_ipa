import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../router/app_page.dart';
import '../controllers/boarding_controller.dart';

class SplashView extends GetView<BoardingController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Start a timer to navigate after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(Routes.loading); // Replace with your actual login route
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: CircleAvatar(
            child: Image.asset(
              "assets/images/logo_new.png",
              //Assets.pngs.icons.logoApp.path,
              width: 1024.w,
              height: 1024.h,
              // color: AppColors.green018701,
            ),
          ),
        ),
      ),
    );
  }
}
