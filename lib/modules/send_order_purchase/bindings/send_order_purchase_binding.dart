import 'package:get/get.dart';

import '../controllers/send_order_purchase_controller.dart';

class SendOrderPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SendOrderPurchaseController());
  }
}