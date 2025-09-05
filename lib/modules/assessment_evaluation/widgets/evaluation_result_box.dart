import 'package:fido_box_demo01/core/common_widget/currency_util.dart';
import 'package:fido_box_demo01/modules/assessment_evaluation/widgets/voucher_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

// ✅ i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

import 'dynamic_evaluation_bottom_sheet.dart';
import '../controllers/assessment_evaluation_controller.dart';

class EvaluationResultBox extends StatelessWidget {
  const EvaluationResultBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AssessmentEvaluationController>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${controller.result.model}  ${controller.result.capacity}',
                    style: AppTypography.s14.bold.withColor(AppColors.neutral01),
                  ),
                ),
                GestureDetector(
                  onTap: () => _handleReEvaluation(controller),
                  child: Row(
                    children: [
                      Image.asset(Assets.images.icDinhgialai.path),
                      SizedBox(width: 8.w),
                      Text(
                        LocaleKeys.action_re_evaluate.trans(),
                        style: AppTypography.s12.regular.withColor(
                          AppColors.neutral04,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Total price row
            Row(
              children: [
                Obx(() {
                  final basePrice = controller.result.evaluatedPrice;
                  final voucherDiscount =
                      controller.selectedVoucher.value?.discountAmount ?? 0;
                  final finalPrice = basePrice + voucherDiscount;

                  return Text(
                    formatCurrency(finalPrice),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  );
                }),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    // Sử dụng DynamicEvaluationBottomSheet mới
                    DynamicEvaluationBottomSheet.show(controller.result);
                  },
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.view_guide.trans(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.help_outline, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Breakdown
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F0),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPriceDetail(
                    formatCurrency(controller.result.evaluatedPrice),
                    LocaleKeys.price_suggested.trans(),
                  ),
                  const Text('+', style: TextStyle(color: Colors.grey)),
                  Obx(() {
                    final voucher = controller.selectedVoucher.value;

                    return InkWell(
                      onTap: () => VoucherBottomSheet.show(context),
                      child: voucher == null
                          ? _buildPriceDetail(
                        LocaleKeys.no_voucher.trans(),
                        LocaleKeys.tap_to_select.trans(),
                        color: Colors.grey,
                      )
                          : _buildPriceDetail(
                        voucher.amount,
                        LocaleKeys.voucher_applied.trans(),
                        color: Colors.red,
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Info row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    ' ${controller.result.warranty}',
                    style: AppTypography.s12.regular.withColor(
                      AppColors.neutral04,
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                        () => Text(
                      // "Thời gian định giá: {time}"
                          '${LocaleKeys.pricing_time_format.trans()} ${controller.remainingTime.value}',
                      style: AppTypography.s12.regular.withColor(
                        AppColors.neutral04,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceDetail(
      String value,
      String label, {
        Color color = Colors.black,
      }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w600, color: color),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color, fontSize: 12)),
      ],
    );
  }

  /// Xử lý định giá lại - quay về trang EvaluateProductView
  void _handleReEvaluation(AssessmentEvaluationController controller) {
    controller.resetEvaluationState();
    Get.back(); // Quay về trang trước đó (EvaluateProductView)
    // print('🔄 Đã quay về trang EvaluateProductView để định giá lại');
  }
}
