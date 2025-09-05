import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/common_widget/currency_util.dart';

// ✅ i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

import '../domain/evaluate_result_model.dart';
import '../controllers/assessment_evaluation_controller.dart';

class DynamicEvaluationBottomSheet {
  static void show(EvaluateResultModel result) {
    Get.bottomSheet(
      _DynamicEvaluationContent(result: result),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

class _DynamicEvaluationContent extends StatefulWidget {
  final EvaluateResultModel result;

  const _DynamicEvaluationContent({required this.result});

  @override
  State<_DynamicEvaluationContent> createState() => _DynamicEvaluationContentState();
}

class _DynamicEvaluationContentState extends State<_DynamicEvaluationContent> {
  List<String> appliedVouchers = [];
  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    appliedVouchers = List<String>.from(storage.read('applied_vouchers') ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.neutral08,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPriceEstimationSection(),
                    const SizedBox(height: 24),
                    _buildModelName(),
                    const SizedBox(height: 16),
                    _buildSpecificationsGrid(),
                    const SizedBox(height: 24),
                    _buildCloseButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.your_choice.trans(),
                style: AppTypography.s16.bold.copyWith(
                  color: AppColors.neutral01,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.close, color: AppColors.neutral03, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.evaluation_influence_note.trans(),
            style: AppTypography.s12.regular.copyWith(
              color: AppColors.neutral04,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModelName() {
    return Text(
      widget.result.model,
      style: AppTypography.s16.bold.copyWith(
        color: AppColors.neutral01,
      ),
    );
  }

  Widget _buildSpecificationsGrid() {
    final specifications = _getSpecifications();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white, width: 0.5),
      ),
      child: Column(
        children: specifications
            .map((spec) => _buildSpecRow(
          spec['label']!,
          spec['value']!,
          isLast: spec == specifications.last,
        ))
            .toList(),
      ),
    );
  }

  List<Map<String, String>> _getSpecifications() {
    return [
      {'label': LocaleKeys.capacity.trans(), 'value': widget.result.capacity},
      {'label': LocaleKeys.device_version.trans(), 'value': widget.result.version},
      {'label': LocaleKeys.warranty_period.trans(), 'value': widget.result.warranty},
      {'label': LocaleKeys.lock_status.trans(), 'value': widget.result.lockStatus},
      {'label': LocaleKeys.cloud_account.trans(), 'value': widget.result.cloudStatus},
      {'label': LocaleKeys.battery_status.trans(), 'value': widget.result.batteryStatus},
      {'label': LocaleKeys.frame_status.trans(), 'value': widget.result.appearance},
      {'label': LocaleKeys.appearance.trans(), 'value': widget.result.display},
      {'label': LocaleKeys.display.trans(), 'value': widget.result.display},
      {'label': LocaleKeys.repair_parts.trans(), 'value': widget.result.repair},
      {'label': LocaleKeys.screen_repair.trans(), 'value': widget.result.screenRepair},
      {
        'label': LocaleKeys.functionality.trans(),
        'value': widget.result.functionality.isNotEmpty
            ? widget.result.functionality.map((e) => e['label']).join(', ')
            : LocaleKeys.default_vibration.trans(),
      },
    ];
  }

  Widget _buildSpecRow(String label, String value, {bool isLast = false}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: AppColors.white, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: AppColors.white, width: 0.5),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: AppTypography.s14.regular.copyWith(
                    color: AppColors.neutral01,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  style: AppTypography.s14.regular.copyWith(
                    color: AppColors.neutral04,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceEstimationSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral06, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.price_estimation.trans(),
            style: AppTypography.s16.bold.copyWith(color: AppColors.neutral01),
          ),
          const SizedBox(height: 16),
          _buildPriceRow(
            LocaleKeys.estimated_product_price.trans(),
            formatCurrency(widget.result.evaluatedPrice),
            AppColors.neutral03,
          ),
          ..._buildSelectedVouchers(),
          const SizedBox(height: 12),
          Divider(color: AppColors.neutral06, thickness: 0.5),
          const SizedBox(height: 12),
          _buildPriceRow(
            LocaleKeys.estimated_purchase_price.trans(),
            formatCurrency(_calculateFinalPrice()),
            AppColors.neutral01,
            isBold: true,
          ),
          const SizedBox(height: 16),
          _buildPriceNote(),
        ],
      ),
    );
  }

  List<Widget> _buildSelectedVouchers() {
    final controller = Get.find<AssessmentEvaluationController>();
    final selectedVoucher = controller.selectedVoucher.value;

    if (selectedVoucher == null) {
      return [
        const SizedBox(height: 8),
        Text(
          LocaleKeys.no_voucher_selected.trans(),
          style: AppTypography.s14.regular.copyWith(color: AppColors.neutral03),
        ),
      ];
    }

    return [
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.selected_voucher.trans(),
            style: AppTypography.s14.medium.copyWith(color: AppColors.neutral01),
          ),
          Text(
            selectedVoucher.amount,
            style: AppTypography.s14.bold.copyWith(color: AppColors.error),
          ),
        ],
      ),
    ];
  }

  Widget _buildPriceRow(String label, String price, Color priceColor, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: (isBold ? AppTypography.s14.bold : AppTypography.s14.regular)
                .copyWith(color: AppColors.neutral01),
          ),
          Text(
            price,
            style: (isBold ? AppTypography.s14.bold : AppTypography.s14.regular)
                .copyWith(color: priceColor),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.estimated_price_note.trans(),
            style: AppTypography.s12.regular.copyWith(color: AppColors.neutral03),
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.price_change_warning.trans(),
            style: AppTypography.s12.regular.copyWith(color: AppColors.error),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return ElevatedButton(
      onPressed: () => Get.back(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary01,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(LocaleKeys.close.trans()),
    );
  }

  int _calculateFinalPrice() {
    int finalPrice = widget.result.evaluatedPrice;
    final controller = Get.find<AssessmentEvaluationController>();
    final selectedVoucher = controller.selectedVoucher.value;
    if (selectedVoucher != null) {
      final amountStr = selectedVoucher.amount.replaceAll(RegExp(r'[^\d]'), '');
      final voucherAmount = int.tryParse(amountStr) ?? 0;
      finalPrice += voucherAmount;
    }
    return finalPrice;
  }
}
