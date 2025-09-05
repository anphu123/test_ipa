import 'package:get/get.dart';

import '../controllers/fido_purchase_controller.dart';
import '../controllers/seller_review_page_controller.dart';

class FidoPurchaseBinding extends Bindings{
  @override
  void dependencies() {
    // Here you can put your controllers or services that are needed for FidoPurchase
    // For example:
     Get.lazyPut<FidoPurchaseController>(() => FidoPurchaseController());
    // Get.put<FidoPurchaseService>(FidoPurchaseService());.
     Get.lazyPut<SellerReviewPageController>(
           () => SellerReviewPageController(),
     );
  }
}