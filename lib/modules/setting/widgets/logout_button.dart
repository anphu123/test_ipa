import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../core/assets/locale_keys.g.dart';
import '../controllers/setting_controller.dart';


class LogoutButton extends StatelessWidget {
  final controller = Get.put(SettingController());

  LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: controller.handleLogout,
     // icon: const Icon(Icons.logout, color: Colors.red),
      label:  Text(
        LocaleKeys.logout.trans(),
        style: TextStyle(color: AppColors.white),
      ),
    );
  }
}
