import 'package:fido_box_demo01/modules/account_security/controllers/account_security_controller.dart';
import 'package:get/get.dart';

class AccountSecurityBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AccountSecurityController());
  }
}
