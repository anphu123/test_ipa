import 'package:fido_box_demo01/modules/add_credit_card/controllers/add_credit_card_controller.dart';
import 'package:get/get.dart';

class AddCreditCardBinding extends Bindings{
@override
void dependencies() {
  Get.lazyPut(() => AddCreditCardController());
}
}