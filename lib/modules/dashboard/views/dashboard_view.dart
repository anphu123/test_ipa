import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/extensions/string_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/dashboard_controller.dart';

class DashBoardView extends GetView<DashBoardController> {
  DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: PageView(
          controller: controller.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: controller.pages,
          onPageChanged: (index) => controller.selectedIndex.value = index,
        ),
        bottomNavigationBar: Obx(() {
          if (controller.isLoggedIn.value) {
            return _buildBottomNavBar();
          } else {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),

              child: Padding(
                padding: EdgeInsets.all(16),
                child: _buildLoginSuggestion(),
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildLoginSuggestion() {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.login),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.primary01,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // Icon(Icons.login, color: Colors.white),
            // SizedBox(width: 8),
            Text(
              LocaleKeys.login1.trans(),
              style: AppTypography.s16.regular.withColor(AppColors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Obx(() {
      final current = controller.selectedIndex.value;

      return Container(
        height: 85,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Slot 1
                Expanded(
                  child: _buildNavItem(
                    index: 0,
                    iconPath: Assets.images.icHome.path,
                    label: LocaleKeys.home.trans(),
                    isSelected: current == 0,
                  ),
                ),
                // Slot 2
                Expanded(
                  child: _buildNavItem(
                    index: 1,
                    iconPath: Assets.images.icShop.path,
                    label: LocaleKeys.manage_posts.trans(),
                    isSelected: current == 1,
                  ),
                ),
                // Slot 3: Center Button
                Expanded(
                  child: Center(child: _buildCenterButton()),
                ),
                // Slot 4
                Expanded(
                  child: _buildNavItem(
                    index: 2,
                    iconPath: Assets.images.icMessage.path,
                    label: LocaleKeys.mail_box.trans(),
                    isSelected: current == 2,
                  ),
                ),
                // Slot 5
                Expanded(
                  child: _buildNavItem(
                    index: 3,
                    iconPath: Assets.images.icUser.path,
                    label: LocaleKeys.account.trans(),
                    isSelected: current == 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
    required String label,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => controller.onTabSelected(index),
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 64, // cố định để các slot cao bằng nhau
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(
              iconPath,
              width: 24,
              height: 24,
              color: isSelected ? AppColors.primary01 : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.primary01 : Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return InkWell(
      onTap: () => Get.toNamed(Routes.forSale),
      borderRadius: BorderRadius.circular(28),
      child: Padding(
        padding:  EdgeInsets.only(bottom: 8.0),
        child: Center(
          child: Image.asset(
            Assets.images.logoTron.path,
            width: 55, // to hơn so với container
            height: 55,
          ),
        ),
      ),
    );
  }



}
