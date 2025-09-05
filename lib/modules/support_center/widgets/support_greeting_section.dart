import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SupportGreetingSection extends StatelessWidget {
  const SupportGreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        LocaleKeys.greeting_message.trans(),
      style: AppTypography.s20.bold.withColor(AppColors.neutral02),
      textAlign: TextAlign.center,
    );
  }
}
