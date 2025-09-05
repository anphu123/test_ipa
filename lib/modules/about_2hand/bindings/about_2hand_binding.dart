import 'package:get/get.dart';

import '../controllers/about_2hand_controller.dart';

class About2HandBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => About2HandController());

  }
}