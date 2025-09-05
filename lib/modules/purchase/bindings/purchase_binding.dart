import 'package:get/get.dart';

import '../../category_fido_purchase/views/category_fido_purchase_view.dart';
import '../controllers/purchase_controller.dart';

class PurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseController());
    // Nếu có các controller khác liên quan đến purchase, thêm vào đây
    // Get.lazyPut(() => AnotherController());
    Get.lazyPut(()=> CategoryFidoPurchaseView());
  }
}