import 'package:get/get.dart';

import '../controllers/voucher_purchase_controller.dart';

class VoucherPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherPurchaseController>(
      () => VoucherPurchaseController(),
    );
  }
}