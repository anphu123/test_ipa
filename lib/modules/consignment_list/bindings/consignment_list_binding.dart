import 'package:get/get.dart';

import '../controllers/consignment_list_controller.dart';

class ConsignmentListBinding extends Bindings{
  @override
  void dependencies() {
    // Register the ConsignmentListController with GetX's dependency injection system
    Get.lazyPut<ConsignmentListController>(() => ConsignmentListController());
  }
}