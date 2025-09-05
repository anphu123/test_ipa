import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';

class SupportAccountHelpSection extends StatelessWidget {
  const SupportAccountHelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
        LocaleKeys.account_support.trans(),
          style: AppTypography.s14.bold.withColor(AppColors.neutral02),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.phoneChangeNumber);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.neutral04),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.images.icMobile.path),
                const SizedBox(width: 8),
                Text(
                  LocaleKeys.change_phone_number.trans(),
                  style: AppTypography.s12.bold.withColor(AppColors.neutral02),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
