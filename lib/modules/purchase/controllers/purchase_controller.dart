
import 'dart:io';

import 'package:get/get.dart';
import '../domain/purchase_product_model.dart';
import '../../../core/assets/assets.gen.dart';

class PurchaseController extends GetxController {
  final RxSet<int> selectedIndexes = <int>{}.obs;
  final RxInt totalPrice = 0.obs;
  final RxList<File> uploadedImages = <File>[].obs;

  final RxString feedbackText = ''.obs;

  void toggleProductSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
    _updateTotalPrice();
  }

  void _updateTotalPrice() {
    totalPrice.value = selectedIndexes
        .map((i) => products[i].price)
        .fold(0, (sum, price) => sum + price);
  }

  final products = <PurchaseProductModel>[
    PurchaseProductModel(
      name: "Xiaomi 15 Ultra",
      price: 85000000,
      discount: "5000000",
      bonus: "600000",
      image: Assets.images.bear1.path,
    ),
    PurchaseProductModel(
      name: "iPhone 15 Pro Max",
      price: 95000000,
      discount: "3000000",
      bonus: "800000",
      image: Assets.images.bear1.path,
    ),
    PurchaseProductModel(
      name: "Samsung Galaxy S24 Ultra",
      price: 90000000,
      discount: "4000000",
      bonus: "700000",
      image: Assets.images.bear1.path,
    ),
    PurchaseProductModel(
      name: "Google Pixel 8 Pro",
      price: 80000000,
      discount: "2000000",
      bonus: "500000",
      image: Assets.images.bear1.path,
    ),
  ];

  final pricingHistory = PurchaseProductModel(
    name: "Xiaomi 15 Ultra",
    price: 35000000,
    discount: "500000",
    bonus: "600000",
    image: Assets.images.bear1.path,
  );
}
