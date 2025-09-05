import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

Widget buildEmailField() {
  final controller = Get.find<RegisterController>();
  return Obx(
    () => TextField(
      controller: controller.mailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: LocaleKeys.email.trans(),
        hintText: LocaleKeys.enter_email.trans(),
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.yellowFidoBoxText, width: 2),
        ),
        errorText:
            controller.mailError.value.isEmpty
                ? null
                : controller.mailError.value,
      ),
      onChanged: controller.validateMail,
    ),
  );
}
