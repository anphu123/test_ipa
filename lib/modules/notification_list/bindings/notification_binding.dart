import 'package:fido_box_demo01/modules/notification_list/controllers/notification_list_controller.dart';
import 'package:get/get.dart';

class NotificationListBinding extends Bindings {
  @override
  void dependencies() {
    // Register the NotificationController with GetX dependency injection
    Get.lazyPut<NotificationListController>(() => NotificationListController());
  }
}