import 'package:get/get.dart';

import '../controllers/community_standards_controller.dart';

class CommunityStandardsBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => CommunityStandardsController());
  }
}