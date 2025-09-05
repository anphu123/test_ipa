import 'package:get/get.dart';

import '../controllers/order_purchase_at_home_controller.dart';

class OrderPurchaseAtHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderPurchaseAtHomeController());
  }
}