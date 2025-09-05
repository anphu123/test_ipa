import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/common_widget/currency_util.dart';
import '../../../router/app_page.dart';
import '../../assessment_evaluation/domain/evaluate_result_model.dart';
import '../../category_fido_purchase/domain/model_variant.dart';
import '../../evaluate_result/domain/evaluate_result_model.dart';
import '../../evaluate_result/views/evaluate_result_view.dart';
import '../domain/evaluate_step_model.dart';


class EvaluateProductController extends GetxController {
  final _storage = GetStorage();
  final currentStep = 0.obs;
  final evaluatedPrice = 0.obs;
  final stepData = EvaluateStepData().obs;
  final RxnInt editingStepIndex = RxnInt(); // null nếu không ở chế độ chỉnh sửa

  final ModelVariant variant = Get.arguments;

  Timer? _scrollTimer;

  int get totalSteps => 11;
  bool get isLastStep => currentStep.value == totalSteps - 1;
  bool get isCurrentStepCompleted {
    final s = stepData.value;
    switch (currentStep.value) {
      case 0: return s.capacity?.isNotEmpty ?? false;
      case 1: return s.version?.isNotEmpty ?? false;
      case 2: return s.warranty?.isNotEmpty ?? false;
      case 3: return s.lockStatus?.isNotEmpty ?? false;
      case 4: return s.cloudStatus?.isNotEmpty ?? false;
      case 5: return s.batteryStatus?.isNotEmpty ?? false;
      case 6: return s.appearance?.isNotEmpty ?? false;
      case 7: return s.display?.isNotEmpty ?? false;
      case 8: return s.repair?.isNotEmpty ?? false;
      case 9: return s.screenRepair?.isNotEmpty ?? false;
      case 10: return s.functionality.isNotEmpty;
      default: return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadFromCache();
    clearForm();// Clear old data when new arguments are received
    _updateEvaluatedPrice();
  }

  void _loadFromCache() {
    final s = stepData.value;
    s.capacity = _storage.read('capacity');
    s.version = _storage.read('version');
    s.warranty = _storage.read('warranty');
    s.lockStatus = _storage.read('lock');
    s.cloudStatus = _storage.read('icloud');
    s.batteryStatus = _storage.read('battery');
    s.appearance = _storage.read('appearance');
    s.display = _storage.read('display');
    s.repair = _storage.read('repair');
    s.screenRepair = _storage.read('screenRepair');
    s.functionality = List<Map<String, dynamic>>.from(_storage.read('functionality') ?? []);
    stepData.refresh();
  }
  void clearForm() {
    // Reset step data
    stepData.value = EvaluateStepData();
    currentStep.value = 0;
    evaluatedPrice.value = 0;
    editingStepIndex.value = null;

    // Clear cache
    clearCache();
  }
  void _saveToCache(String key, dynamic value) => _storage.write(key, value);

  void _updateEvaluatedPrice() {
    evaluatedPrice.value = (variant.price ?? 0) + stepData.value.totalOffset;
  }

  void scrollToNextStep(ScrollController controller) {
    if (currentStep.value < 4) return;
    final offset = currentStep.value * 300.0;
    controller.animateTo(offset, duration: 500.milliseconds, curve: Curves.easeInOut);
  }

  void nextStep() {
    if (!isCurrentStepCompleted) {
      Get.snackbar('Thiếu thông tin', 'Vui lòng chọn một tùy chọn trước khi tiếp tục.');
      return;
    }
    if (!isLastStep) currentStep.value++;
  }

  void previousStep() => currentStep.value--;
  void editStep(int index) {
    if (index >= 0 && index < totalSteps) {
      editingStepIndex.value = currentStep.value; // Lưu lại vị trí hiện tại
      currentStep.value = index;
    }
  }

  void handleStepAdvance() {
    if (editingStepIndex.value != null) {
      currentStep.value = editingStepIndex.value!;
      editingStepIndex.value = null;
    } else {
      nextStep();
    }
  }

  // Setters
  void setCapacity(String label, int offset) {
    stepData.update((s) {
      s!.capacity = label;
      s.capacityOffset = offset;
    });
    _saveToCache('capacity', label);
    _updateEvaluatedPrice();
   handleStepAdvance();
  }

  void setVersion(String label, int offset) {
    stepData.update((s) {
      s!.version = label;
      s.versionOffset = offset;
    });
    _saveToCache('version', label);
    _updateEvaluatedPrice();
   handleStepAdvance();
  }

  void setWarranty(String label, int offset) {
    stepData.update((s) {
      s!.warranty = label;
      s.warrantyOffset = offset;
    });
    _saveToCache('warranty', label);
    _updateEvaluatedPrice();
   handleStepAdvance();
  }

  void setLockStatus(String label, int offset) {
    stepData.update((s) {
      s!.lockStatus = label;
      s.lockOffset = offset;
    });
    _saveToCache('lock', label);
    _updateEvaluatedPrice();
   handleStepAdvance();
  }

  void setCloudStatus(String label, int offset) {
    stepData.update((s) {
      s!.cloudStatus = label;
      s.cloudOffset = offset;
    });
    _saveToCache('icloud', label);
    _updateEvaluatedPrice();
   handleStepAdvance();
  }

  void setBatteryStatus(String label, int offset) {
    stepData.update((s) {
      s!.batteryStatus = label;
      s.batteryOffset = offset;
    });
    _saveToCache('battery', label);
    _updateEvaluatedPrice();
   handleStepAdvance();
  }

  void setAppearance(String label, int offset) {
    stepData.update((s) {
      s!.appearance = label;
      s.appearanceOffset = offset;
    });
    _saveToCache('appearance', label);
    _updateEvaluatedPrice();
   handleStepAdvance();
  }

  void setDisplay(String label, int offset) {
    stepData.update((s) {
      s!.display = label;
      s.displayOffset = offset;
    });
    _saveToCache('display', label);
    _updateEvaluatedPrice();
   handleStepAdvance();
  }

  void setRepair(String label, int offset) {
    stepData.update((s) {
      s!.repair = label;
      s.repairOffset = offset;
    });
    _saveToCache('repair', label);
    _updateEvaluatedPrice();
   handleStepAdvance();
  }

  void setScreenRepair(String label, int offset) {
    stepData.update((s) {
      s!.screenRepair = label;
      s.screenRepairOffset = offset;
    });
    _saveToCache('screenRepair', label);
    _updateEvaluatedPrice();
   handleStepAdvance();
  }

  void setFunctionality(List<Map<String, dynamic>> values) {
    stepData.update((s) => s!.functionality = values.isEmpty ? [] : values);
    _saveToCache('functionality', values);
    _updateEvaluatedPrice();
    handleStepAdvance();
  }

  void onEvaluateSubmit() {
    final s = stepData.value;

    final isIncomplete = [
      s.capacity,
      s.version,
      s.warranty,
      s.lockStatus,
      s.cloudStatus,
      s.batteryStatus,
      s.appearance,
      s.display,
      s.repair,
      s.screenRepair
    ].any((e) => e == null || e.isEmpty);

    if (isIncomplete) {
      Get.snackbar('Thiếu thông tin', 'Vui lòng hoàn thành tất cả các bước.');
      return;
    }

    final result = EvaluateResultModel(
      model: variant.name ?? '',
      capacity: stepData.value.capacity ?? '',
      version: stepData.value.version ?? '',
      warranty: stepData.value.warranty ?? '',
      lockStatus: stepData.value.lockStatus ?? '',
      cloudStatus: stepData.value.cloudStatus ?? '',
      batteryStatus: stepData.value.batteryStatus ?? '',
      appearance: stepData.value.appearance ?? '',
      display: stepData.value.display ?? '',
      repair: stepData.value.repair ?? '',
      screenRepair: stepData.value.screenRepair ?? '',
      functionality: s.functionality.isNotEmpty ? s.functionality : [{'label': 'Không có',}],
      evaluatedPrice: evaluatedPrice.value,
    );

    Get.toNamed(Routes.assessmentEvaluation,arguments: result); // ✅ Truyền object chuẩn

  }
  void clearCache() {
    _storage.remove('capacity');
    _storage.remove('version');
    _storage.remove('warranty');
    _storage.remove('lock');
    _storage.remove('icloud');
    _storage.remove('battery');
    _storage.remove('appearance');
    _storage.remove('display');
    _storage.remove('repair');
    _storage.remove('screenRepair');
    _storage.remove('functionality');
  }
}
