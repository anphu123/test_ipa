import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../controllers/personal_profile_controller.dart';

class IntroductionScreen extends StatefulWidget {
  IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final controller = Get.find<PersonalProfileController>();
  final TextEditingController _introController = TextEditingController();
  final int maxLength = 300;

  @override
  void initState() {
    super.initState();
    _introController.text = controller.introduction.value;
    _introController.addListener(() {
      setState(() {}); // cập nhật số ký tự
    });
  }

  @override
  void dispose() {
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: Text(
          LocaleKeys.personal_intro.trans(),
          // style: TextStyle(color: Colors.black),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Container(
          padding: EdgeInsets.all(12.w),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding:  EdgeInsets.all(8.r),
                margin:  EdgeInsets.only(bottom: 30.h),
                child: TextField(
                  controller: _introController,

                  maxLines: null,
                  maxLength: maxLength,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.enter_description.trans(),
                    hintStyle: AppTypography.s14.regular.withColor(
                      AppColors.neutral05,
                    ),
                    border: InputBorder.none,
                    counterText: "",
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Text(
                  "${_introController.text.length}/$maxLength",
                  style: AppTypography.s14.regular.withColor(
                    AppColors.neutral05,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
            boxShadow: [

            BoxShadow(
              color: AppColors.neutral01.withOpacity(0.05),
              offset: Offset(0, -4),
              blurRadius: 20,
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10.h),
            height: 48.h,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary01,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () async {
                final newIntro = _introController.text.trim();
                await controller.updateIntroduction(newIntro);
                Get.back();
                Get.snackbar(LocaleKeys.success.trans(), LocaleKeys.personal_description_saved.trans(),);
              },
              child: Text(
                LocaleKeys.save.trans(),
                style: AppTypography.s16.regular.withColor(AppColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
