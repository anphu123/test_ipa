import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    // Register the NotificationController with GetX dependency injection
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}