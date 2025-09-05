import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

// Giả sử bạn đã có AppTypography và AppColors
// import 'app_typography.dart';
// import 'app_colors.dart';

class FaqListCard extends StatelessWidget {
  const FaqListCard({
    super.key,

    required this.items,
    this.onViewDetail,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 12,
  });


  final List<FaqItemData> items;
  final VoidCallback? onViewDetail;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.frequently_asked_questions.trans(),
                    style: AppTypography.s16.semibold.withColor(
                      AppColors.neutral01,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onViewDetail,
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocaleKeys.view_detail.trans(),
                        style: AppTypography.s14.regular.withColor(
                          AppColors.neutral04,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: AppColors.neutral04,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Full list trong 1 container
            ...items.map(
              (faq) => Container(
                color: AppColors.white,
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      faq.question,
                      style: AppTypography.s14.medium.withColor(
                        AppColors.neutral01,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      faq.answer,
                      style: AppTypography.s12.regular.withColor(
                        AppColors.neutral04,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FaqItemData {
  final String question;
  final String answer;

  const FaqItemData({required this.question, required this.answer});
}
