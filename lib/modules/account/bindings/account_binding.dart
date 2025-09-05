import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountBinding extends Bindings {
  @override
    @override
  void dependencies() {
    Get.put<AccountController>(AccountController());
  }
}