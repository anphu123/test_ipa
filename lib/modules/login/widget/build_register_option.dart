import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../router/app_page.dart';
import '../controllers/login_controller.dart';

Widget buildRegisterOption() {
  final controller = Get.find<LoginController>();
  return Column(
    children: [
      SizedBox(height: 16.h),
      Row(
        children: [
          Expanded(child: Divider(thickness: 1, indent: 24.w, endIndent: 8.w)),
          Text(
            LocaleKeys.option_login.trans(),
          //  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            style: AppTypography.s12.regular.withColor(AppColors.neutral03),
          ),
          Expanded(child: Divider(thickness: 1, indent: 8.w, endIndent: 24.w)),
        ],
      ),
      SizedBox(height: 16.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialButton(Assets.images.logoFacebook.path, () {
            // TODO: Thêm xử lý đăng nhập Facebook
          }),
          SizedBox(width: 24.w),
          _buildSocialButton(Assets.images.logoGoogle.path, () {
            // loginWithGoogle();
            controller.loginWithGoogle();
            // TODO: Thêm xử lý đăng nhập Google
          }), SizedBox(width: 24.w),
          _buildSocialButton(Assets.images.logoZalo.path, () {
            // loginWithGoogle();
            controller.loginWithGoogle();
            // TODO: Thêm xử lý đăng nhập Google
          }),
        ],
      ),
      SizedBox(height: 10.h),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text(
      //       LocaleKeys.dont_have_account.trans(),
      //       style: TextStyle(fontSize: 14.sp),
      //     ),
      //     TextButton(
      //       onPressed: () {
      //         // TODO: Add Register logic
      //         Get.toNamed(Routes.register);
      //       },
      //       child: Text(
      //         LocaleKeys.register.trans(),
      //         style: TextStyle(
      //           color: AppColors.yellowFidoBoxText,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 14.sp,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    ],
  );
}

Widget _buildSocialButton(String iconPath, VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(40.r),
    child: Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.neutral08,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Image.asset(iconPath, fit: BoxFit.contain),
      ),
    ),
  );
}
