import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/core/assets/assets.gen.dart';

class VoucherPurchaseBottomNav extends StatelessWidget {
  final RxInt currentIndex;
  final Function(int) onTap;

  const VoucherPurchaseBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNavItem(
                index: 0,
                iconPath: Assets.images.icVoucher.path,
                label: "Voucher",
              ),
              _buildNavItem(
                index: 1,
                iconPath: Assets.images.icVoucher.path,
                label: "Ví Voucher",
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconPath,
    required String label,
  }) {
    final isSelected = currentIndex.value == index;

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
}
