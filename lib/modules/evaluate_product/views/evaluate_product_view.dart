import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/common_widget/currency_util.dart';
import '../../category_fido_purchase/domain/model_variant.dart';
import '../controllers/evaluate_product_controller.dart';
import '../widgets/appearance_step.dart';
import '../widgets/battery_status_step.dart';

import '../widgets/capacity_step.dart';
import '../widgets/cloud_status_step.dart';
import '../widgets/display_step.dart';
import '../widgets/functionality_step.dart';
import '../widgets/lock_status_step.dart';
import '../widgets/repair_step.dart';
import '../widgets/screen_repair_step.dart';
import '../widgets/version_step.dart';
import '../widgets/warranty_step.dart';

class EvaluateProductView extends GetView<EvaluateProductController> {
  final ModelVariant variant;

  const EvaluateProductView({super.key, required this.variant});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final controller = Get.put(EvaluateProductController());

    final steps = [
      CapacityStep(onSelected: controller.setCapacity),
      VersionStep(onSelected: controller.setVersion),
      WarrantyStep(onSelected: controller.setWarranty),
      LockStatusStep(onSelected: controller.setLockStatus),
      CloudStatusStep(onSelected: controller.setCloudStatus),
      BatteryStatusStep(onSelected: controller.setBatteryStatus),
      AppearanceStep(onSelected: controller.setAppearance),
      DisplayStep(onSelected: controller.setDisplay),
      RepairStep(onSelected: controller.setRepair),
      ScreenRepairStep(onSelected: controller.setScreenRepair),
      FunctionalityStep(onSelected: controller.setFunctionality),
    ];

    ever(controller.currentStep, (_) {
      controller.scrollToNextStep(scrollController);
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: Obx(() {
        final step = controller.currentStep.value;
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProgressIndicator(step, steps.length),
                    const SizedBox(height: 12),
                    _buildPriceDisplay(),
                    if (step > 0) _buildCompletedSummaries(controller),
                    steps[step],
                  ],
                ),
              ),
            ),
            _buildBottomButton(controller),
          ],
        );
      }),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      title:  Text(LocaleKeys.used_machine_valuation.trans()),
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildPriceDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary01,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                variant.name,
                style: AppTypography.s16.regular.withColor(AppColors.neutral01),
              ),
            ],
          ),
          const SizedBox(width: 8),

          // Obx(
          //   () => Text(
          //     "Giá đề xuất: ${formatCurrency(Get.find<EvaluateProductController>().evaluatedPrice.value)}",
          //     style: AppTypography.s16.bold.withColor(AppColors.primary01),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(EvaluateProductController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed:
              controller.isLastStep
                  ? controller.onEvaluateSubmit
                  : controller.nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary01,
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            controller.isLastStep ? LocaleKeys.action_price_now.trans() : LocaleKeys.continue_btn.trans(),
            style: AppTypography.s16.regular.withColor(AppColors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int step, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.neutral07,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: (step + 1) / total,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(AppColors.primary01),
              minHeight: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${step + 1}/$total',
              style: AppTypography.s10.regular.withColor(AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedSummaries(EvaluateProductController controller) {
    final s = controller.stepData.value;
    final List<Widget> summaries = [];

    final data = [
      {'label': LocaleKeys.capacity.trans(), 'value': s.capacity},
      {'label': LocaleKeys.machine_version.trans(), 'value': s.version},
      {'label':LocaleKeys.warranty_period.trans(), 'value': s.warranty},
      {'label': LocaleKeys.startup_status.trans(), 'value': s.lockStatus},
      {'label':  LocaleKeys.personal_account.trans(), 'value': s.cloudStatus},
      {'label': LocaleKeys.battery_status.trans(), 'value': s.batteryStatus},
      {'label': LocaleKeys.case_bezel.trans(), 'value': s.appearance},
      {'label': LocaleKeys.display.trans(), 'value': s.display},
      {'label': LocaleKeys.repair_replace_parts.trans(), 'value': s.repair},
      {'label': LocaleKeys.screen_repair_replacement.trans(), 'value': s.screenRepair},
      {
        'label': 'Chức năng',
        'value': s.functionality.map((e) => e['label']).join(', '),
      },
    ];

    for (int i = 0; i < controller.currentStep.value; i++) {
      final d = data[i];
      summaries.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${d['label']}: ',
                style: AppTypography.s14.regular.withColor(AppColors.neutral01),
              ),
              SizedBox(width: 32.w),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        '${d['value']}',
                        style: AppTypography.s14.regular.withColor(
                          AppColors.neutral04,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    //   Image.asset(Assets.images.icEdit.path,color: AppColors.neutral04,)
                    IconButton(
                      icon: SizedBox(
                        width: 16,
                        height: 16,
                        child: Assets.images.icEdit.image(),
                      ),
                      onPressed: () => controller.editStep(i),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(children: summaries);
  }
}
