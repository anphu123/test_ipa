import 'package:get/get.dart';

import '../controllers/list_store_controller.dart';

class ListStoreBinding extends Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => ListStoreController());
  }
}