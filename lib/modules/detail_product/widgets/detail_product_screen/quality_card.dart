import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/detail_product/controllers/detail_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/assets/locale_keys.g.dart';

class QualityCard extends GetView<DetailProductController> {
  const QualityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.selectedQuality.value;
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.neutral07, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$selected - B',
                      style: AppTypography.s24.bold.withColor(
                        AppColors.neutral01,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () => _showEvaluationCriteriaBottomSheet(context),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.classification_standard.trans(),
                            style: AppTypography.s12.regular.withColor(
                              AppColors.neutral03,
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.chevron_right,
                            size: 16.w,
                            color: AppColors.neutral04,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _pill(
                            '${LocaleKeys.appearance_selected.trans()} $selected',
                            bg: const Color(0xFFEAF2FF),
                            fg: const Color(0xFF2F6BFF),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                            LocaleKeys.appearance_good.trans(),
                              style: AppTypography.s10.regular.withColor(
                                AppColors.neutral01,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _pill(
                            LocaleKeys.grade_b.trans(),
                            bg: const Color(0xFFFFF3D6),
                            fg: const Color(0xFFAF7A00),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              selected == 99
                                  ? LocaleKeys.battery_good_90_95.trans()
                                  : LocaleKeys.battery_good_80_85.trans(),
                              style: AppTypography.s10.regular.withColor(
                                AppColors.neutral01,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              LocaleKeys.device_condition.trans(),
              style: AppTypography.s14.semibold.withColor(AppColors.neutral02),
            ),
            SizedBox(height: 8.h),
            _specRowScrollable( [
              ('80%–85%',LocaleKeys.percent_pin.trans()),
              (LocaleKeys.less_than_30_days.trans(), LocaleKeys.warranty.trans(),),
              (LocaleKeys.never_changed_battery.trans(), LocaleKeys.battery_condition.trans(),),
              (LocaleKeys.no_accessories.trans(), LocaleKeys.accessories.trans(),),
              (LocaleKeys.icloud_free.trans(), LocaleKeys.account.trans(),),
              (LocaleKeys.faceid_touchid_ok.trans(), LocaleKeys.verify.trans(),),
            ]),
            Text(
              LocaleKeys.specifications.trans(),
              style: AppTypography.s14.semibold.withColor(AppColors.neutral02),
            ),
            SizedBox(height: 8.h),
            _specRowScrollable( [
              ('80%–85%', LocaleKeys.percent_pin.trans()),
              (LocaleKeys.less_than_30_days.trans(), LocaleKeys.warranty.trans(),),
              (LocaleKeys.never_changed_battery.trans(), LocaleKeys.battery_condition.trans(),),
              (LocaleKeys.no_accessories.trans(), LocaleKeys.accessories.trans(),),
            ]),
          ],
        ),
      );
    });
  }

  Widget _pill(String text, {required Color bg, required Color fg}) {
    return Container(
      constraints: BoxConstraints(

        minWidth: 110.w, // 🔹 Đặt chiều dài tối thiểu giống nhau
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: bg.withOpacity(0.6)),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTypography.s12.medium.withColor(fg),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


  Widget _specRowScrollable(List<(String, String)> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            items
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.only(right:1.w),
                    child: _specTile(value: e.$1, label: e.$2),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _specTile({required String value, required String label}) {
    return Container(
      width: 120.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTypography.s14.semibold.withColor(AppColors.neutral01),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTypography.s12.regular.withColor(AppColors.neutral04),
          ),
        ],
      ),
    );
  }
}

void _showEvaluationCriteriaBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => const _EvaluationCriteriaSheet(),
  );
}

class _EvaluationCriteriaSheet extends StatelessWidget {
  const _EvaluationCriteriaSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final rows = <_EvalRow>[
      _EvalRow(
        percent:  LocaleKeys.percent_99_new.trans(),
        note:  LocaleKeys.no_wear.trans(),
        grade: 'S',
        desc:
        LocaleKeys.functions_perfect.trans(),
      ),
      _EvalRow(
        percent:  LocaleKeys.percent_95_new.trans(),
        note:  LocaleKeys.light_wear.trans(),
        grade: 'A',
        desc:  LocaleKeys.functions_good.trans(),
      ),
      _EvalRow(
        percent:  LocaleKeys.percent_90_new.trans(),
        note:  LocaleKeys.medium_wear.trans(),
        grade: 'B',
        desc:
        LocaleKeys.functions_basic_good.trans(),
      ),
      _EvalRow(
        percent:  LocaleKeys.percent_80_new.trans(),
        note:  LocaleKeys.heavy_wear.trans(),
        grade: 'C',
        desc:
        LocaleKeys.functions_ok.trans(),
      ),
    ];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 12.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Title
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        LocaleKeys.evaluation_criteria.trans(),
                        style: AppTypography.s16.semibold.withColor(
                          AppColors.neutral01,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // BẢNG 2 CỘT
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                  },
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: AppColors.neutral06,
                      width: 1,
                    ),
                    verticalInside: BorderSide(
                      color: AppColors.neutral06,
                      width: 1,
                    ),
                    // Có thể thêm viền ngoài nếu muốn:
                    top: BorderSide(color: AppColors.neutral06),
                    left: BorderSide(color: AppColors.neutral06),
                    right: BorderSide(color: AppColors.neutral06),
                    bottom: BorderSide(color: AppColors.neutral06),
                  ),
                  children: [
                    // ROW 0: HEADER (màu khác)
                    TableRow(
                      decoration: BoxDecoration(color: AppColors.neutral07),
                      children:  [
                        _HeaderCell(
                          title:  LocaleKeys.appearance_condition.trans(),
                          subtitle:  LocaleKeys.appearance_subtitle.trans(),
                        ),
                        _HeaderCell(
                          title:  LocaleKeys.function_condition.trans(),
                          subtitle:
                          LocaleKeys.function_subtitle.trans(),
                        ),
                      ],
                    ),

                    // Các ROW dữ liệu
                    for (final r in rows)
                      TableRow(
                        decoration: const BoxDecoration(color: Colors.white),
                        children: [
                          _AppearanceCell(item: r),
                          _FunctionCell(item: r),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== Cells =====

class _HeaderCell extends StatelessWidget {
  final String title;
  final String subtitle;

  const _HeaderCell({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.s12.semibold.withColor(AppColors.neutral02),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTypography.s12.regular.withColor(AppColors.neutral04),
          ),
        ],
      ),
    );
  }
}

class _AppearanceCell extends StatelessWidget {
  final _EvalRow item;

  const _AppearanceCell({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text trái
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.percent,
                  style: AppTypography.s14.bold.withColor(AppColors.neutral02),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.note,
                  style: AppTypography.s12.regular.withColor(
                    AppColors.neutral04,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Ảnh phải
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              width: 56.w,
              height: 56.w * 1.2,
              child: Image.asset(
                Assets.images.pXiaomi15.path, // đổi asset nếu cần
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FunctionCell extends StatelessWidget {
  final _EvalRow item;

  const _FunctionCell({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GradeChip(text: item.grade),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              item.desc,
              style: AppTypography.s12.regular.withColor(AppColors.neutral03),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradeChip extends StatelessWidget {
  final String text;

  const _GradeChip({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.neutral07,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.neutral06),
      ),
      child: Text(
        text,
        style: AppTypography.s12.semibold.withColor(AppColors.neutral02),
      ),
    );
  }
}

class _EvalRow {
  final String percent;
  final String note;
  final String grade;
  final String desc;

  _EvalRow({
    required this.percent,
    required this.note,
    required this.grade,
    required this.desc,
  });
}
