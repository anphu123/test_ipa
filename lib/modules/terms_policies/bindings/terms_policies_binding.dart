import 'package:get/get.dart';

import '../controllers/terms_policies_controller.dart';

class TermsPoliciesBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => TermsPoliciesController());

  }
}