import 'package:get/get.dart';

import '../controllers/for_sale_controller.dart';

class ForSaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForSaleController>(() => ForSaleController());
  }

}