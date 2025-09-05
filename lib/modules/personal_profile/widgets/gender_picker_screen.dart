// views/gender_picker_screen.dart
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/personal_profile_controller.dart';

class GenderPickerScreen extends StatelessWidget {
  final controller = Get.find<PersonalProfileController>();

  final List<String> genders = [LocaleKeys.male.trans(), LocaleKeys.female.trans(), LocaleKeys.other.trans()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Chọn giới tính', style: AppTypography.s16.bold),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.separated(
        itemCount: genders.length,
        separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.neutral07),
        itemBuilder: (context, index) {
          final gender = genders[index];
          return Obx(() => ListTile(
            title: Text(
              gender,
              style: AppTypography.s16.regular,
            ),
            trailing: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: controller.gender.value == gender 
                      ? AppColors.primary01 
                      : AppColors.neutral03,
                  width: 2,
                ),
                color: controller.gender.value == gender 
                    ? AppColors.primary01 
                    : Colors.transparent,
              ),
              child: controller.gender.value == gender
                  ? Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 16,
                    )
                  : null,
            ),
            onTap: () {
              controller.setGender(gender);
              Get.back();
            },
          ));
        },
      ),
    );
  }
}