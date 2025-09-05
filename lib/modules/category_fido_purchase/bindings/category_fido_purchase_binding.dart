import 'package:fido_box_demo01/modules/category_fido_purchase/domain/category_mock_data.dart';
import 'package:get/get.dart';

import '../controllers/category_fido_purchase_controller.dart';

class CategoryFidoPurchaseBinding extends Bindings{
  @override
  void dependencies() {
    // Bind the controller to the GetX dependency injection system
    Get.lazyPut(() => CategoryFidoPurchaseController(mockCategoryList));
  }
}