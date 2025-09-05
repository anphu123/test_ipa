import 'package:get/get.dart';
import '../domain/mock_save_data.dart';
import '../domain/saved_product_model.dart';


class SavedProductController extends GetxController {
  final products = <SavedProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    products.assignAll(mockSavedProducts);
  }
}
