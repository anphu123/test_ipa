import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../router/app_page.dart';

Widget buildForgotPasswordButton() {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        // TODO: Add Forgot Password logic
        Get.toNamed(Routes.forgotPassword);
      },
      child: Text(
        LocaleKeys.forgot_password.trans(),
        style: const TextStyle(color: AppColors.yellowFidoBoxText),
      ),
    ),
  );
}
