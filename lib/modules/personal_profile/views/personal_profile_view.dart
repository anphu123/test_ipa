import 'dart:io';

import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/personal_profile/widgets/area_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';
import '../../setting/widgets/logout_button.dart';
import '../controllers/personal_profile_controller.dart';
import '../widgets/edit_profile_screen.dart';
import '../widgets/gender_picker_screen.dart';
import '../widgets/introduction_screen.dart';
import '../widgets/manage_personal_screen.dart';

class PersonalProfileView extends StatelessWidget {
  PersonalProfileView({super.key});

  final controller = Get.find<PersonalProfileController>();
  final double profileCompletion = 0.90;

  @override
  Widget build(BuildContext context) {
    final percentText = (profileCompletion * 100).toInt().toString();

    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          LocaleKeys.personal_profile.trans(),
          style: AppTypography.s16.regular.withColor(AppColors.neutral02),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildProgress(percentText),
              SizedBox(height: 16),
              _buildSection([
                Obx(
                  () => _buildItem(
                    LocaleKeys.avatar.trans(),
                    isAvatar: true,
                    avatarFile: controller.avatarImage.value,
                    onTap: () => controller.showPickerOptions(context),
                  ),
                ),
                Obx(
                  () => _buildItem(
                    LocaleKeys.nickname.trans(),
                    isName: true,
                    nickname: controller.nickname.value,
                    onTap: () async {
                      await Get.to(
                        () => EditProfileScreen(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 300),
                      );
                      // loadProfileInfo(); // reload sau khi quay về
                    },
                  ),
                ),
                Obx(
                  () => _buildItem(
                    LocaleKeys.gender.trans(),
                    isGender: true,
                    gender: controller.gender.value,
                    onTap: () async {
                      await Get.to(() => GenderPickerScreen());
                      controller.loadGender();
                    },
                  ),
                ),
                Obx(
                  () => _buildItem(
                    LocaleKeys.birth_date.trans(),
                    birthDateText:
                        controller.birthDate.value != null
                            ? DateFormat(
                              'dd/MM/yyyy',
                            ).format(controller.birthDate.value!)
                            : LocaleKeys.not_selected.trans(),
                    onTap: () async {
                      DateTime tempDate =
                          controller.birthDate.value ??
                          DateTime.now().subtract(Duration(days: 18 * 365));
                      DateTime? pickedDate =
                          await showModalBottomSheet<DateTime>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            builder: (_) => _buildDatePicker(context, tempDate),
                          );
                      if (pickedDate != null) {
                        controller.setBirthDate(pickedDate);
                      }
                    },
                  ),
                ),
                _buildItem(
                  LocaleKeys.personal_intro.trans(),
                  onTap: () => Get.to(() => IntroductionScreen()),

                ),
                _buildItem(
                  LocaleKeys.user_identification.trans(),
                  onTap: () => Get.toNamed(Routes.userIdentification),
                  isLast: true,
                ),
              ]),

              _buildSection([
                Obx(
                  () => _buildItem(
                    LocaleKeys.area.trans(),
                    areaText: controller.area.value,
                    isLast: true,
                    onTap: () async {
                      final selectedArea = await Get.to(
                        () => const AreaScreen(),
                      );
                      if (selectedArea != null) {
                        controller.setArea(selectedArea);
                      }
                    },
                  ),
                ),
              ]),
              _buildSection([
                _buildItem(
                  LocaleKeys.manage_profile_page.trans(),
                  onTap: () => Get.to(() => ManagePersonalScreen()),
                  isLast: true,
                ),
              ]),
            ],
          ),
        ),
      ),
    //   bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildProgress(String percentText) {
    return Container(
      height: 94.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: LocaleKeys.completed.trans(),
              style: AppTypography.s20.regular.withColor(AppColors.neutral02),
              children: [
                TextSpan(
                  text: ' $percentText%',
                  style: AppTypography.s32.bold.copyWith(
                    color: AppColors.primary01,
                  ),
                ),
                TextSpan(text: ' , '+LocaleKeys.try_your_best.trans(),),
              ],
            ),
          ),
          SizedBox(height: 8),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: profileCompletion),
            duration: Duration(milliseconds: 800),
            builder: (context, value, _) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: AppColors.neutral06,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primary01,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    String title, {
    VoidCallback? onTap,
    bool isLast = false,
    bool isAvatar = false,
    bool isName = false,
    bool isGender = false,
    File? avatarFile,
    String? nickname,
    String? gender,
    String? birthDateText,
    String? areaText,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: AppTypography.s16.regular.withColor(AppColors.neutral01),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isAvatar)
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage:
                      avatarFile != null
                          ? FileImage(avatarFile)
                          : AssetImage("assets/images/default_avatar.png")
                              as ImageProvider,
                ),
              if (isName)
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Text(
                    nickname ?? '',
                    style: AppTypography.s16.regular.withColor(
                      AppColors.neutral04,
                    ),
                  ),
                ),
              if (isGender)
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Text(
                    gender ?? '',
                    style: AppTypography.s16.regular.withColor(
                      AppColors.neutral04,
                    ),
                  ),
                ),
              if (birthDateText != null)
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Text(
                    birthDateText,
                    style: AppTypography.s16.regular.withColor(
                      AppColors.neutral04,
                    ),
                  ),
                ),
              if (areaText != null)
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Text(
                    areaText,
                    style: AppTypography.s16.regular.withColor(
                      AppColors.neutral04,
                    ),
                  ),
                ),
              Icon(Icons.chevron_right, color: AppColors.neutral03),
            ],
          ),
          onTap: onTap ?? () {},
        ),
        if (!isLast) Container(height: 1, color: AppColors.neutral07),
      ],
    );
  }

  Widget _buildSection(List<Widget> items) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: items),
    );
  }

  Widget _buildDatePicker(BuildContext context, DateTime initialDate) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    LocaleKeys.cancel.trans(),
                    style: AppTypography.s16.semibold.withColor(
                      AppColors.neutral04,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(initialDate),
                  child: Text(
                    LocaleKeys.select.trans(),
                    style: AppTypography.s16.semibold.withColor(
                      AppColors.primary01,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                minimumDate: DateTime(1900),
                maximumDate: DateTime.now().subtract(Duration(days: 18 * 365)),
                onDateTimeChanged: (value) {
                  initialDate = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            offset: Offset(0, -4),
            blurRadius: 20,
            color: AppColors.neutral01.withOpacity(0.05),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          margin: EdgeInsets.only(bottom: 16.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primary01,
            borderRadius: BorderRadius.circular(8),
          ),
          child: LogoutButton(),
        ),
      ),
    );
  }
}
