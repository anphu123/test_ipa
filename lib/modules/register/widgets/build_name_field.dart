import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

Widget buildNameField() {
  final controller = Get.find<RegisterController>();
  return Obx(
    () => TextField(
      controller: controller.nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: LocaleKeys.name.trans(),
        hintText: LocaleKeys.enter_name.trans(),
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.yellowFidoBoxText, width: 2),
        ),
        errorText:
            controller.nameError.value.isEmpty
                ? null
                : controller.nameError.value,
      ),
      onChanged: controller.validateName,
    ),
  );
}
