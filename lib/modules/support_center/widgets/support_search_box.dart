import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class SupportSearchBox extends StatelessWidget {
  const SupportSearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral04),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: LocaleKeys.search_placeholder.trans(),
          border: InputBorder.none,
          icon: Image.asset(Assets.images.icSearch.path),
        ),
      ),
    );
  }
}
