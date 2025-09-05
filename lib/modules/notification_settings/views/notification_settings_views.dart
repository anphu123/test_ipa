import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

import '../controllers/notification_settings_controller.dart';

class NotificationSettingsView extends GetView<NotificationSettingsController> {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          LocaleKeys.notification_setting.trans(),
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
              _buildToggleItem(LocaleKeys.notification.trans(), controller.isNotificationOn),
              _buildToggleItem(
                LocaleKeys.notification_bell.trans(),
                controller.isSoundOn,
                isLast: true,
              ),
            ]),
            _buildSection([
              _buildToggleItem(
                LocaleKeys.order.trans(),
                controller.isOrderOn,
                subtitle: LocaleKeys.order_status_update.trans(),
              ),
              _buildToggleItem(
                LocaleKeys.chat.trans(),
                controller.isChatOn,
                subtitle: LocaleKeys.chat_messages.trans(),
                isLast: true,
              ),
            ]),
            _buildSection([
              _buildToggleItem(
                LocaleKeys.promotion.trans(),
                controller.isPromoOn,
                subtitle: LocaleKeys.promotion_update.trans(),
                isLast: true,
              ),
            ]),
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
