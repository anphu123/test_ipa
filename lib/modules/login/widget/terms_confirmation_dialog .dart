
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';

class TermsConfirmationDialog extends StatelessWidget {
  final VoidCallback onAgree;
  final RxBool isTermsAccepted;

  const TermsConfirmationDialog({
    Key? key,
    required this.onAgree,
    required this.isTermsAccepted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              'THÔNG BÁO',
              style: AppTypography.s20.bold.withColor(AppColors.neutral01),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Content
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: LocaleKeys.have_read.trans() + ' ',
                style: AppTypography.s12.regular.withColor(AppColors.neutral01),
                children: [
                  TextSpan(
                    text: LocaleKeys.terms.trans(),
                    style: AppTypography.s12.regular.withColor(AppColors.AB01),
                  ),
                  const TextSpan(text: ', '),
                  TextSpan(
                    text: LocaleKeys.privacy_policy.trans(),
                    style: AppTypography.s12.regular.withColor(AppColors.AB01),
                  ),
                  TextSpan(text: ' ${LocaleKeys.and.trans()} '),
                  TextSpan(
                    text: 'Chia sẻ dữ liệu với bên thứ ba',
                    style: AppTypography.s12.regular.withColor(AppColors.AB01),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.neutral01),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Hủy',
                      style: AppTypography.s16.regular.withColor(AppColors.neutral01),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close dialog
                      isTermsAccepted.value = true;
                      onAgree(); // Execute next logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary01,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Đồng ý',
                      style: AppTypography.s16.regular.withColor(AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}