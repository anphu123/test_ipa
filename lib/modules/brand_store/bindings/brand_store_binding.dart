// lib/modules/brand_store/brand_store_binding.dart
import 'package:get/get.dart';

import '../controllers/brand_store_controller.dart';


class BrandStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandStoreController>(() => BrandStoreController());
  }
}
