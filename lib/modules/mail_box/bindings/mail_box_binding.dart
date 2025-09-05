
import 'package:get/get.dart';

import '../controllers/mail_box_controller.dart';

class MailBoxBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MailBoxController>(() => MailBoxController());
  }

}