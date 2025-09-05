import 'dart:io';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/user_identification_controller.dart';

class UserIdentificationView extends StatefulWidget {
  const UserIdentificationView({Key? key}) : super(key: key);

  @override
  State<UserIdentificationView> createState() => _UserIdentificationViewState();
}

class _UserIdentificationViewState extends State<UserIdentificationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final controller = Get.put(UserIdentificationController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final newIndex = _tabController.index;
        controller.currentTabIndex.value = newIndex;

        if (newIndex == 1 && controller.frontImage.value == null) {
          Get.snackbar('Cảnh báo', 'Vui lòng chụp mặt trước CCCD trước');
          _tabController.index = 0;
          controller.currentTabIndex.value = 0;
        } else if (newIndex == 2 && controller.backImage.value == null) {
          Get.snackbar( LocaleKeys.notification.trans(), 'Vui lòng chụp mặt sau CCCD trước');
          _tabController.index = 1;
          controller.currentTabIndex.value = 1;
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          LocaleKeys.user_identification.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Obx(() => buildStepIndicator(controller.currentTabIndex.value)),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildUploadCardSection(
                  title: LocaleKeys.upload_front_id.trans(),
                  description:
                  LocaleKeys.upload_portrait_tip.trans(),
                  imageFile: controller.frontImage,
                  onTap: () async {
                    await controller.pickFrontCardImage();
                    // if (controller.frontImage.value != null) {
                    //   _tabController.animateTo(1);
                    //   controller.currentTabIndex.value = 1;
                    // }
                  },
                  placeholderImagePath: Assets.images.bgCccd.path,
                ),
                buildUploadCardSection(
                  title: LocaleKeys.upload_back_id.trans(),
                  description:
                    LocaleKeys.upload_portrait_tip.trans(),
                  imageFile: controller.backImage,
                  onTap: () async {
                    await controller.pickBackCardImage();
                    // if (controller.backImage.value != null) {
                    //   _tabController.animateTo(2);
                    //   controller.currentTabIndex.value = 2;
                    // }
                  },
                  placeholderImagePath: Assets.images.bgCccdsau.path,
                ),
                buildFaceUploadSection(
                  imageFile: controller.faceImage,
                  onTap: controller.captureFaceImage,
                  onContinue: controller.onContinue,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        final currentIndex = controller.currentTabIndex.value;
        final canContinue =
            (currentIndex == 0 && controller.frontImage.value != null) ||
            (currentIndex == 1 && controller.backImage.value != null) ||
            (currentIndex == 2 && controller.faceImage.value != null);

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed:
                canContinue
                    ? () {
                      if (currentIndex == 0) {
                        controller.currentTabIndex.value = 1;
                        _tabController.animateTo(1);
                      } else if (currentIndex == 1) {
                        controller.currentTabIndex.value = 2;
                        _tabController.animateTo(2);
                      } else {
                        controller.onContinue();
                      }
                    }
                    : () {
                      Get.snackbar(
                        'Thiếu thông tin',
                        'Vui lòng chụp ảnh trước khi tiếp tục',
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  canContinue ? AppColors.primary01 : AppColors.neutral04,
              padding: const EdgeInsets.symmetric(vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              currentIndex < 2 ? 'Tiếp tục' : 'Xác nhận',
              style: AppTypography.s16.medium.withColor(Colors.white),
            ),
          ),
        );
      }),
    );
  }

  Widget buildFaceUploadSection({
    required Rx<File?> imageFile,
    required VoidCallback onTap,
    required VoidCallback onContinue,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onTap,
            child: Obx(() {
              final file = imageFile.value;
              return file == null
                  ? Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red,
                        style: BorderStyle.solid,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        Assets.images.bgChandung.path,
                        // thay bằng Assets.images.avatarPlaceholder.path nếu bạn dùng flutter_gen
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                  : CircleAvatar(radius: 110, backgroundImage: FileImage(file));
            }),
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(LocaleKeys.note_1.trans(),),
              Text(LocaleKeys.note_2.trans(),),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget buildStepIndicator(int currentStep) {
    const totalSteps = 3;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index == currentStep;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 40,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary02 : AppColors.neutral06,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }

  Widget buildUploadCardSection({
    required String title,
    required String description,
    required Rx<File?> imageFile,
    required VoidCallback onTap,
    String? placeholderImagePath,
    bool showContinue = false,
    VoidCallback? onContinue,
    bool isCircleImage = false,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTypography.s20.bold.withColor(AppColors.neutral01),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: AppTypography.s14.regular.withColor(AppColors.neutral04),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          /// Ảnh
          GestureDetector(
            onTap: onTap,
            child: Obx(() {
              final file = imageFile.value;

              return Container(
                padding: EdgeInsets.all(2.r),
                width: 295.h,
                height: 200.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.neutral04,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    file != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            file,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                        : placeholderImagePath != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            placeholderImagePath,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ],
                        ),
              );
            }),
          ),

          const SizedBox(height: 24),

          /// Checklist sát lề trái
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.note_1.trans(),
                    style: AppTypography.s14.regular.withColor(
                      AppColors.neutral02,
                    ),
                  ),
                  Text(
                    LocaleKeys.note_2.trans(),
                    style: AppTypography.s14.regular.withColor(
                      AppColors.neutral02,
                    ),
                  ),
                  Text(
                    LocaleKeys.note_3.trans(),
                    style: AppTypography.s14.regular.withColor(
                      AppColors.neutral02,
                    ),
                  ),
                  Text(
                    LocaleKeys.note_4.trans(),
                    style: AppTypography.s14.regular.withColor(
                      AppColors.neutral02,
                    ),
                  ),
                  Text(
                    LocaleKeys.note_5.trans(),
                    style: AppTypography.s14.regular.withColor(
                      AppColors.neutral02,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
