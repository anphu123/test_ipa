import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SupportMoreInfoSection extends StatelessWidget {
  const SupportMoreInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.ask_more_info.trans(), style: AppTypography.s14.bold),
          const SizedBox(height: 16),
          _buildSupportOption(
            icon: Assets.images.icCskh.path,
            text: 'Yêu cầu của tôi',
            subtitle: "Chưa có yêu cầu nào",
            onTap: () {},
          ),_buildSupportOption(
            icon: Assets.images.icCskh.path,
            text: LocaleKeys.chat_with_2hand.trans(),
            onTap: () {},
          ),
          // _buildDivider(),
          _buildSupportOption(
            icon: Assets.images.icCskh.path,
            text: LocaleKeys.call_hotline.trans(),
            badgeText:LocaleKeys.free_of_charge.trans(),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOption({
    required String icon,
    required String text,
    String? subtitle,
    String? badgeText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(icon, width: 24, height: 24, color: AppColors.primary01),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          style: AppTypography.s14,
                        ),
                      ),
                      if (badgeText != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary01),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badgeText,
                            style: AppTypography.s10.withColor(AppColors.primary01),
                          ),
                        ),
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: AppTypography.s12.withColor(AppColors.neutral03),
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.neutral04),
          ],
        ),
      ),
    );
  }


  Widget _buildDivider() => Container(height: 1, color: AppColors.neutral06);
}
