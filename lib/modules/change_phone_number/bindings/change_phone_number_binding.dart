import 'package:fido_box_demo01/modules/change_phone_number/controllers/change_phone_number_controller.dart';
import 'package:get/get.dart';

class ChangePhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePhoneNumberController>(
      () => ChangePhoneNumberController(),
    );
  }
}
