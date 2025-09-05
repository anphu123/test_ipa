import 'package:get/get.dart';

import '../controllers/zalo_notification_controller.dart';

class ZaloNotificationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

      Get.lazyPut(() => ZaloNotificationController());

  }
}