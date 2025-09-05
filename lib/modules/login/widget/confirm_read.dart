import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/login/controllers/login_controller.dart';
import 'package:fido_box_demo01/modules/login/widget/terms_bottom_sheet.dart';
import 'package:fido_box_demo01/modules/register/controllers/register_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';

Widget confirmRead() {
  final controller = Get.find<LoginController>();

  void _showTerms(String title) {
    Get.bottomSheet(
      TermsBottomSheet(
        title: title,
        contentList: [
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...',
        ],
      ),
      isScrollControlled: true,
    );
  }

  return Obx(
        () => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          focusColor: AppColors.primary01,
          activeColor: AppColors.primary01,
          value: controller.isTermsAccepted.value,
          onChanged: (value) {
            controller.isTermsAccepted.value = value ?? false;
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: LocaleKeys.have_read.trans() + ' ',
              style: AppTypography.s12.regular.withColor(AppColors.neutral01),
              children: [
                TextSpan(
                  text: LocaleKeys.terms.trans(),
                  style: AppTypography.s12.regular.withColor(AppColors.AB01),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _showTerms(LocaleKeys.terms.trans()),
                ),
                TextSpan(text: ' , '),
                TextSpan(
                  text: LocaleKeys.privacy_policy.trans(),
                  style: AppTypography.s12.regular.withColor(AppColors.AB01),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _showTerms(LocaleKeys.privacy_policy.trans()),
                ),
                TextSpan(text: ' ${LocaleKeys.and.trans()} '),
                TextSpan(
                  text: LocaleKeys.share_data.trans(),
                  style: AppTypography.s12.regular.withColor(AppColors.AB01),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _showTerms(LocaleKeys.share_data.trans()),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
