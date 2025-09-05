import 'package:get/get.dart';

import '../controllers/evaluate_product_controller.dart';

class EvaluateProductBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => EvaluateProductController());

  }
}