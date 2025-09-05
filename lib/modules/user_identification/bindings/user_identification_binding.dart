import 'package:fido_box_demo01/modules/user_identification/controllers/user_identification_controller.dart';
import 'package:get/get.dart';

class UserIdentificationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => UserIdentificationController());

  }
}