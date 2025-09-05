import 'package:get/get.dart';

import '../controllers/set_up_push_noti_push_controller.dart';

class SetUpPushNotiPushBinding extends Bindings {
    @override
    void dependencies() {
      Get.lazyPut(() => SetUpPushNotiPushController());
    }
}