import 'package:get/get.dart';

import '../../evaluate_result/controllers/evaluate_result_controller.dart';
import '../controllers/assessment_evaluation_controller.dart';
import '../../home_pickup_zone/controllers/home_pickup_zone_controller.dart';

class AssessmentEvaluationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssessmentEvaluationController());
    // Đảm bảo HomePickupZoneController có sẵn để lấy địa chỉ mặc định
    Get.lazyPut(() => HomePickupZoneController());
    // Get.lazyPut(()=>EvaluateResultController());
  }
}