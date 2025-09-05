import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../core/assets/assets.gen.dart';
import '../controllers/login_controller.dart';
import '../widget/build_forgot_password_button.dart';
import '../widget/build_id_field.dart';
import '../widget/build_language_selection.dart';
import '../widget/build_login_button.dart';
import '../widget/build_password_field.dart';
import '../widget/build_register_option.dart';
import '../widget/build_welcome_text.dart';
import '../widget/confirm_read.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Image.asset(Assets.images.logoFull.path, height: 50.h),
        centerTitle: true,
      ),

      body: Center(
        child: KeyboardDismisser(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildWelcomeText(),
                SizedBox(height: 20.h),
                PhoneNumberField(
                  controller: controller.phoneController,
                  onPhoneCodeChanged: controller.setPhoneCode,
                ),
                SizedBox(height: 16.h),
                buildOtpField(),
                confirmRead(),
                SizedBox(height: 15.h),
                buildRegisterOption(),
                SizedBox(height: 15.h),

                SizedBox(height: 20.h), // khoảng cách cho phần dưới cùng
              ],
            ),
          ),
        ),
      ),

      // ⬇ Nút Đăng nhập đặt cố định bên dưới
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: buildLoginButton(),
      ),
    );
  }
}
