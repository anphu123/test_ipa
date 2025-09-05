import 'package:get/get.dart';

import '../controllers/sms_notification_controller.dart';

class SmsNotificationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

      Get.lazyPut(() => SmsNotificationController());

  }
}