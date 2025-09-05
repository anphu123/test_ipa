import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';
import '../controllers/set_up_push_noti_push_controller.dart';

class SetUpPushNotiPushView extends GetView<SetUpPushNotiPushController> {
  const SetUpPushNotiPushView({super.key});

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
          LocaleKeys.push_notification_setting.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
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
                LocaleKeys.notification_setting.trans(),
                onTap: () => Get.toNamed(Routes.notificationSetting),
              ),
              _buildItem(
                LocaleKeys.in_app_notification.trans(),
                onTap: () => Get.toNamed(Routes.inAppNotification),
              ),
              _buildItem(
                LocaleKeys.email_notification.trans(),
                onTap: () => Get.toNamed(Routes.emailNotification),

              ),
              _buildItem(
                LocaleKeys.sms_notification.trans(),
                onTap: () => Get.toNamed(Routes.smsNotification),

              ),
              _buildItem(
                LocaleKeys.zalo_notification.trans(),
                onTap: () => Get.toNamed(Routes.zaloNotification),
                isLast: true,
              ),
            ]),
          ],
        ),
      ),
    );
  }
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
  }
