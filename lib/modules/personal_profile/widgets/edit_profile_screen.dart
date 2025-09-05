import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../account/controllers/account_controller.dart';
import '../controllers/personal_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final controller = Get.find<PersonalProfileController>();
  final nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nicknameController.text = controller.nickname.value;

    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          LocaleKeys.rename.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              final text = nicknameController.text.trim();
              if (text.isEmpty) {
                Get.snackbar("Lỗi", LocaleKeys.nickname_required.trans());
                return;
              }
              if (text.length > 20) {
                Get.snackbar("Lỗi", "Biệt danh tối đa 20 ký tự");
                return;
              }
              // TODO: Check last changed date < 90 days
              controller.updateNickname(text);
              await Get.find<AccountController>().updateNickname(text);
              await Get.find<HomeController>().updateNickname(text);
              controller.saveProfile();
              Get.back();
            },
            child: Text(
              LocaleKeys.save.trans(),
              style: AppTypography.s14.regular.withColor(AppColors.primary01),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.AW02,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                LocaleKeys.nickname_change_note.trans(),
                // style: TextStyle(
                //   fontSize: 13,
                //   color:  AppColors.AW01,
                // ),
                style: AppTypography.s14.regular.withColor(AppColors.AW01),
              ),
            ),
            SizedBox(height: 24.h),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: nicknameController,
                  maxLength: 20,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: LocaleKeys.enter_nickname.trans(),
                    counterText: "",
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    controller.nickname.value = value.trim();
                  },
                ),
                if (nicknameController.text.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      nicknameController.clear();
                      controller.nickname.value = '';
                    },
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              LocaleKeys.nickname_hint.trans(),

              style: AppTypography.s12.regular.withColor(AppColors.neutral04),
              // style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
