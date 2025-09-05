import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ProductDetailSection extends StatelessWidget {
  final String description;

  const ProductDetailSection({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
    //  padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        // borderRadius: BorderRadius.circular(12.r),
        // border: Border.all(color: AppColors.neutral07, width: 1),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.04),
        //     blurRadius: 10,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề
          Text(
            'Chi tiết sản phẩm',
            style: AppTypography.s16.medium.withColor(AppColors.neutral01),
          ),
          SizedBox(height: 8.h),

          // Nội dung rút gọn/mở rộng
          ExpandableText(
            text: description,
            trimLength: 120, // cắt khoảng 120 ký tự
          ),
        ],
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLength;

  const ExpandableText({
    Key? key,
    required this.text,
    this.trimLength = 100,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final displayText = isExpanded
        ? widget.text
        : (widget.text.length > widget.trimLength
        ? widget.text.substring(0, widget.trimLength) + '...'
        : widget.text);

    return RichText(
      text: TextSpan(
        style: AppTypography.s14.regular.withColor(AppColors.neutral03),
        children: [
          TextSpan(text: displayText),
          if (widget.text.length > widget.trimLength)
            TextSpan(
              text: isExpanded ? LocaleKeys.collapse.trans() : LocaleKeys.see_more.trans(),
              style: AppTypography.s14.regular.copyWith(color: AppColors.primary01),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() => isExpanded = !isExpanded);
                },
            ),
        ],
      ),
    );
  }
}
