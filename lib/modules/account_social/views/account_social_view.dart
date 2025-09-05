import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/account_social_controller.dart';

class AccountSocialView extends GetView<AccountSocialController> {
  AccountSocialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          LocaleKeys.social_media_accounts.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        //  padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          _buildWarningCard(),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: _buildInstruction(),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(color: AppColors.white),
            child: Column(
              children: [
                _buildSocialItem(
                  'Google',
                  Assets.images.logoGoogle.path,
                  controller.isGoogleLinked.value,
                ),

                _buildSocialItem(
                  'Facebook',
                  Assets.images.logoFacebook.path,
                  controller.isFacebookLinked.value,
                ),

                _buildSocialItem(
                  'Zalo',
                  Assets.images.logoZalo.path,
                  controller.isZaloLinked.value,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.AW02,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: Colors.amber),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.transaction_warning.trans(),
            //   style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
            style: AppTypography.s14.regular.withColor(AppColors.AW01),
          ),
          SizedBox(height: 8),
          // Text(
          //   'Tuyệt đối không chuyển tiền riêng tư bên ngoài hệ thống. Luôn nhớ rằng, sử dụng đảm bảo của 2Hand sẽ an toàn hơn rất nhiều!',
          //   style: AppTypography.s14.regular.withColor(AppColors.AW01),
          // ),
        ],
      ),
    );
  }

  Widget _buildInstruction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.contact_info.trans(),
          style: AppTypography.s16.semibold.withColor(AppColors.neutral01),
        ),
        Container(
          padding: EdgeInsets.only(left: 5.w),
          child: Text(
            LocaleKeys.contact_edit_note.trans(),
            style: AppTypography.s14.regular.withColor(AppColors.neutral03),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialItem(String name, String imagePath, bool isLinked) {
    return ListTile(
      leading: Container(
        width: 32.w,
        height: 32.w,
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
      title: Text(
        name,
        style: AppTypography.s16.regular.withColor(AppColors.neutral01),
      ),
      trailing: TextButton(
        onPressed: () {
          isLinked
              ? controller.unlinkAccount(name)
              : controller.linkAccount(name);
        },
        child: Text(
          isLinked ? LocaleKeys.remove_link.trans() : LocaleKeys.link.trans(),
          style: AppTypography.s14.medium.withColor(AppColors.primary01),
        ),
      ),
    );
  }
}
