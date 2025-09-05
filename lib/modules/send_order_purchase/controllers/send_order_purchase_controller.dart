import 'package:get/get.dart';

import '../../purchase/domain/purchase_product_model.dart';

class SendOrderPurchaseController extends GetxController {
  late PurchaseProductModel product;
  late int index;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    product = args['product'] as PurchaseProductModel;
    index = args['index'] as int;
  }
}