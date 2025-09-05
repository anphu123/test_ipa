import 'package:get/get.dart';
import '../controllers/order_purchase_at_store_controller.dart';
import '../../list_store/controllers/list_store_controller.dart';

class OrderPurchaseAtStoreBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure ListStoreController is available and initialized
    Get.put<ListStoreController>(ListStoreController(), permanent: true);

    // Force load stores if not already loaded
    final storeController = Get.find<ListStoreController>();
    if (storeController.stores.isEmpty) {
      storeController.loadStores();
    }

    Get.lazyPut<OrderPurchaseAtStoreController>(
      () => OrderPurchaseAtStoreController(),
    );
  }
}
