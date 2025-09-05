import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/setting/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../router/app_page.dart';
import '../widgets/logout_button.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  Widget _buildItem(String title, {VoidCallback? onTap, bool isLast = false}) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: AppTypography.s16.regular.withColor(AppColors.neutral01),
          ),
          trailing: const Icon(Icons.chevron_right, color: AppColors.neutral03),
          onTap: onTap ?? () {},
        ),
        if (!isLast) Container(height: 1, color: AppColors.neutral06),
      ],
    );
  }

  Widget _buildSection(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: items),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          LocaleKeys.setting.trans(),
          style: AppTypography.s16.regular.withColor(AppColors.neutral02),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection([
              _buildItem(
                LocaleKeys.account_security.trans(),
                onTap: () => Get.toNamed(Routes.accountSecurity),
              ),
              _buildItem( LocaleKeys.address.trans(), onTap: () => Get.toNamed(Routes.address),),
              _buildItem(
                LocaleKeys.bank_account.trans(),
                onTap: () => Get.toNamed(Routes.paymentAccount),
                isLast: true,
              ),
            ]),
            _buildSection([
              _buildItem( LocaleKeys.push_notification_setting.trans(), onTap: () => Get.toNamed(Routes.setUpPushNotiPush),),
              _buildItem( LocaleKeys.privacy_setting.trans(), onTap: () => Get.toNamed(Routes.privacySetting)),
              _buildItem( LocaleKeys.block_list.trans(), onTap: () => Get.toNamed(Routes.blockList)),
              _buildItem( LocaleKeys.language.trans(),onTap: () => Get.toNamed(Routes.languageSetting), isLast: true),
            ]),
            _buildSection([
              _buildItem( LocaleKeys.business_cooperation.trans(),),
              _buildItem( LocaleKeys.support_center.trans(),onTap: () => Get.toNamed(Routes.supportCenter)),
              _buildItem( LocaleKeys.community_standards.trans(),onTap: () => Get.toNamed(Routes.communityStandards)),
              _buildItem( LocaleKeys.terms_policies.trans(),onTap: () => Get.toNamed(Routes.termsPolicies)),

              _buildItem( LocaleKeys.about_2hand.trans(),onTap: () => Get.toNamed(Routes.about2Hand) ),
              _buildItem( LocaleKeys.review_2hand.trans(),isLast: true),

            ]),
            _buildSection([_buildItem( LocaleKeys.delete_account.trans(), isLast: true)]),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary01,
                borderRadius: BorderRadius.circular(8),
              ),
              child: LogoutButton(),
            ),
          ],
        ),
      ),
    );
  }
}
