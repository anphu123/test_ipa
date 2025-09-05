import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';
import '../controllers/change_phone_number_controller.dart';

class ChangePhoneNumberView extends GetView<ChangePhoneNumberController> {
  const ChangePhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            LocaleKeys.change_phone.trans(),
            style: AppTypography.s20.medium.withColor(AppColors.neutral01)
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.select_verification_method.trans(),
              style: AppTypography.s16.semibold.withColor(AppColors.neutral01),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildMethodTile(
                    icon: Icons.phone_iphone_sharp,
                    title: LocaleKeys.use_sms_code.trans(),
                    subtitle: LocaleKeys.code_sent_to_phone.trans(),
                    onTap: () => Get.toNamed(Routes.phoneChangeNumber),
                  ),
                  //_divider(),
                  _buildMethodTile(
                    iconAsset: Assets.images.logoGoogle.path,
                    title:  LocaleKeys.verify_google_auth.trans(),
                    subtitle:  LocaleKeys.use_sms_code.trans(),
                    onTap: () {},
                  ),
                //  _divider(),
                  _buildMethodTile(
                    iconAsset: Assets.images.logoZalo.path,
                    title: LocaleKeys.verify_zalo_auth.trans(),
                    subtitle: 'Mã sẽ được gửi về Zalo của bạn',
                   onTap: (){},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 // Widget _divider() => Divider(height: 1, color: AppColors.neutral05);

  Widget _buildMethodTile({
    IconData? icon,
    String? iconAsset,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
    onTap: onTap,
      leading: icon != null
          ? Icon(icon, color: AppColors.primary01)
          : Image.asset(
        iconAsset!,
        width: 24.w,
        height: 24.w,
      ),
      title: Text(
        title,
        style: AppTypography.s16.regular.withColor(AppColors.neutral01),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.s14.regular.withColor(AppColors.neutral04),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.neutral04),
    );
  }
}
