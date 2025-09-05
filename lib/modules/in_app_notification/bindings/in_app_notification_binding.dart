import 'package:get/get.dart';

import '../controllers/in_app_notification_controller.dart';

class InAppNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InAppNotificationController());
  }
}