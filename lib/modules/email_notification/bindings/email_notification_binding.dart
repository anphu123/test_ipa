import 'package:get/get.dart';

import '../controllers/email_notification_controller.dart';

class EmailNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailNotificationController());
  }
}