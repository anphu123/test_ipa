import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/change_phone_number/controllers/change_phone_number_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/locale_keys.g.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../login/widget/build_id_field.dart';
import '../../login/widget/build_password_field.dart';

class PhoneChangeNumberView extends GetView<ChangePhoneNumberController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thay đổi số điện thoại',
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: AppColors.neutral08,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PhoneNumberField(
              controller: controller.phoneController,
              onPhoneCodeChanged: controller.setPhoneCode,
            ),
            SizedBox(height: 16.h),
            buildOtpField1(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: buildLoginButton(),
      ),
    );
  }
}

Widget buildLoginButton() {
  //final controller = Get.find<LoginController>();
  return ElevatedButton(
    // onPressed: controller.isLoading.value ? null : controller.loginWithOtp,
    onPressed: () {
      Get.back();
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary01,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
    ),
    child:
    // controller.isLoading.value
    //     ? const SizedBox(
    //   height: 20,
    //   width: 20,
    //   child: CircularProgressIndicator(
    //     color: AppColors.white,
    //     strokeWidth: 2,
    //   ),
    // )
    //     :
    Text(
      //  LocaleKeys.confirm_ignore.trans(),
        LocaleKeys.confirm.trans(),
      style: AppTypography.s14.withColor(AppColors.white),
    ),
  );
}

Widget buildOtpField1() {
  final controller = Get.find<ChangePhoneNumberController>();
  return Obx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller.otpController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: LocaleKeys.get_otp.trans(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.neutral01, width: 1.w),
            ),
            suffixIcon:
                controller.resendSeconds.value > 0
                    ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Gửi lại mã sau ${controller.resendSeconds.value}s',
                        style: AppTypography.s12.regular.withColor(
                          AppColors.primary01,
                        ),
                      ),
                    )
                    : controller.isSendingOtp.value
                    ? Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                    : TextButton(
                      onPressed: controller.sendOtp,
                      child: Text(
                        // 'Nhận mã OTP',
                        LocaleKeys.get_otp.trans(),
                        style: AppTypography.s12.regular.withColor(
                          AppColors.neutral03,
                        ),
                      ),
                    ),
          ),
        ),
        SizedBox(height: 8.h),
        // TextButton(
        //   child: Text("gui ma"),
        //   onPressed: () {
        //     controller.sendOtp();
        //   },
        // )
      ],
    ),
  );
}
