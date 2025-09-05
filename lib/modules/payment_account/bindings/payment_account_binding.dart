import 'package:fido_box_demo01/modules/payment_account/controllers/payment_account_controller.dart';
import 'package:get/get.dart';

class PaymentAccountBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PaymentAccountController>(
          () => PaymentAccountController(),
    );
  }
}