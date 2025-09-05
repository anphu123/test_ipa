import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/core/assets/assets.gen.dart';
import 'package:fido_box_demo01/router/app_page.dart';

import '../../../core/assets/locale_keys.g.dart';

class FidoPurchaseBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FidoPurchaseBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //   height: 85,
      decoration: BoxDecoration(color: AppColors.white),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNavItem(0, Assets.images.icHome.path, LocaleKeys.home.trans()),
              _buildNavItem(1, Assets.images.icVoucher.path, LocaleKeys.voucher.trans()),
              _buildCenterButton(),
              _buildNavItem(2, Assets.images.icThumuatannoi.path,LocaleKeys.purchase.trans()),
              _buildNavItem(3, Assets.images.icDonhang.path, LocaleKeys.order.trans()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    final isSelected = currentIndex == index;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            style: AppTypography.s12.medium.copyWith(
              color: isSelected ? AppColors.primary01 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterButton() {
    return Container(
      width: 56,
      height: 56,
      // decoration: BoxDecoration(shape: BoxShape.circle),
      child: InkWell(
        //onTap: () => controller.onTabSelected(2),
        // onTap: () => Get.toNamed(Routes.forSale),
        onTap: () {
          Get.toNamed(Routes.categoryFidoPurchase);
        },
        borderRadius: BorderRadius.circular(28),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary01,
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                child: Image.asset(
                  Assets.images.logoHome.path,
                  width: 64,
                  height: 64,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
