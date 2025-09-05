import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AccessoryListCard extends StatelessWidget {


  final String? commonNote; // ví dụ: "Không bao gồm củ sạc, không bao gồm cáp dữ liệu"

  final List<String> extraItems; // ví dụ: ["Hộp đựng x1", "Que chọc SIM x1", ...]

  const AccessoryListCard({
    super.key,


    this.commonNote,

    this.extraItems = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề lớn
        Text( LocaleKeys.accessory_list_title.trans(), style: AppTypography.s14.semibold.withColor(AppColors.neutral02)),
        SizedBox(height: 10.h),

        // Mục 1: Phụ kiện thông dụng
        Text(
          LocaleKeys.common_accessories_title.trans(),
          style: AppTypography.s12.semibold.withColor(AppColors.neutral04),
        ),
        if ((commonNote ?? '').isNotEmpty) ...[
          SizedBox(height: 4.h),
          Text(
            commonNote!,
            style: AppTypography.s12.bold.withColor(AppColors.neutral02),
          ),
        ],

        SizedBox(height: 12.h),

        // Mục 2: Phụ kiện bổ sung
        Text(
          LocaleKeys.extra_accessories_title.trans(),
          style: AppTypography.s12.semibold.withColor(AppColors.neutral04),
        ),
        SizedBox(height: 4.h),
        Text(
          extraItems.isEmpty ? '—' : extraItems.join(' , '),
          style: AppTypography.s12.bold.withColor(AppColors.neutral02),
        ),
      ],
    );
  }
}
