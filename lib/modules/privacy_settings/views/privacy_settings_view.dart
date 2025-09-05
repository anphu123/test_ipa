import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/privacy_settings/controllers/privacy_settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';

class PrivacySettingsView extends GetView<PrivacySettingsController> {
  const PrivacySettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          LocaleKeys.privacy_setting.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection([
              _buildToggleItem(
                LocaleKeys.allow_location.trans(),
                subtitle: LocaleKeys.location_usage.trans(),
                controller.isLocationAccessOn,
              ),
              _buildToggleItem(
                LocaleKeys.allow_contacts.trans(),
                subtitle: LocaleKeys.find_friends.trans(),
                controller.isContactInfoHidden,
              ),
              _buildToggleItem(
                LocaleKeys.allow_microphone.trans(),
                subtitle: LocaleKeys.video_review.trans(),
                controller.isMicrophoneAccessOn,
              ),
              _buildToggleItem(
                LocaleKeys.allow_photos.trans(),
                subtitle: LocaleKeys.photo_review.trans(),
                controller.isPhotoLibraryAccessOn,
              ),
              _buildToggleItem(
                LocaleKeys.allow_camera.trans(),
                subtitle: LocaleKeys.use_camera.trans(),
                controller.isCameraAccessOn,
                isLast: true,
              ),
            ]),
            _buildSection([
              _buildToggleItem(
                LocaleKeys.hide_follow_list.trans(),
                controller.isFollowListHidden,
                subtitle: LocaleKeys.hide_follow_description.trans(),
              ),
              _buildToggleItem(
                LocaleKeys.hide_contact_info.trans(),
                controller.isContactInfoHidden,
                subtitle: LocaleKeys.hide_contact_description.trans(),

                isLast: true,
              ),
            ]),
            // _buildSection([
            //   _buildToggleItem(
            //     "Các Shop",
            //     controller.isPromoOn,
            //     subtitle: 'Cập nhật trên trang cửa hàng',
            //     isLast: true,
            //   ),
            // ]),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem(
    String title,
    RxBool value, {
    String? subtitle,
    bool isLast = false,
  }) {
    return Obx(
      () => Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(title, style: AppTypography.s16),
            subtitle:
                subtitle != null
                    ? Text(
                      subtitle,
                      style: AppTypography.s12.withColor(AppColors.neutral04),
                    )
                    : null,
            trailing: CupertinoSwitch(
              value: value.value,
              activeColor: AppColors.primary01,
              onChanged: (val) => value.value = val,
            ),
          ),
          if (!isLast) Container(height: 1, color: AppColors.neutral06),
        ],
      ),
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
}
