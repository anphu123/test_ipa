import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SupportHighlightButton extends StatelessWidget {
  const SupportHighlightButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Handle tap
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary01,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(Assets.images.icLoaruttien.path, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                  LocaleKeys.withdrawal_fee.trans(),
                style: AppTypography.s12.bold.withColor(Colors.white),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}
