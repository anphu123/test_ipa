import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';


class ExplanationItem {
  final String title;
  final String description;
  ExplanationItem({required this.title, required this.description});
}

class InfoLine {
  final String text;
  final bool muted; // để làm mờ như ngày kiểm định trong ảnh
  InfoLine(this.text, {this.muted = false});
}

class InspectionExplanationSection extends StatelessWidget {

  final List<ExplanationItem> items;
  final VoidCallback? onFeedbackTap;
  final List<InfoLine> infoLines;

  const InspectionExplanationSection({
    super.key,

    required this.items,
    this.onFeedbackTap,
    this.infoLines = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( LocaleKeys.inspection_explanation_title.trans(), style: AppTypography.s14.semibold.withColor(AppColors.neutral02)),
        SizedBox(height: 8.h),

        // các thẻ giải thích
        ...items.map((e) => _explainCard(e)).expand((w) sync* {
          yield w;
          yield SizedBox(height: 10.h);
        }).toList()
          ..removeLast(), // bỏ SizedBox thừa ở cuối

        SizedBox(height: 12.h),

        // hàng phản hồi
        _feedbackRow(),

        SizedBox(height: 12.h),

        // box thông tin kiểm định
        if (infoLines.isNotEmpty) _infoBox(),
      ],
    );
  }

  Widget _explainCard(ExplanationItem e) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(e.title, style: AppTypography.s12.regular.withColor(AppColors.neutral02)),
          SizedBox(height: 6.h),
          Text(
            e.description,
            style: AppTypography.s12.regular.withColor(AppColors.neutral04),
          ),
        ],
      ),
    );
  }

  Widget _feedbackRow() {
    return InkWell(
      onTap: onFeedbackTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(Icons.content_paste,
                size: 20.w, color: AppColors.neutral03),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                  LocaleKeys.inspection_feedback_question.trans(),
                style: AppTypography.s14.regular
                    .withColor(AppColors.neutral02),
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                size: 20.w, color: AppColors.neutral03),
          ],
        ),
      ),
    );
  }

  Widget _infoBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: infoLines
          .map((l) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(
          l.text,
          style: (l.muted
              ? AppTypography.s14.regular
              .withColor(AppColors.neutral04)
              : AppTypography.s14.regular
              .withColor(AppColors.neutral02)),
        ),
      ))
          .toList(),
    );
  }
}
