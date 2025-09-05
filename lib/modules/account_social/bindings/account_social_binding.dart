import 'package:get/get.dart';

import '../controllers/account_social_controller.dart';

class AccountSocialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountSocialController>(
      () => AccountSocialController(),
    );
  }
}
