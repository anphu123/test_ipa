import 'package:get/get.dart';
import '../../home/domain/model/category_model.dart';
import '../../home/domain/model/mock_categories.dart';

class DetailProductController extends GetxController {
  late final ProductModel product;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final showMoreAppearance = false.obs;
  final showMoreSpecs = false.obs;

  void toggleSpecsExpanded() => showMoreSpecs.toggle();

  // Chọn tuỳ chọn chất lượng (99 hoặc 95)
  final RxInt selectedQuality = 99.obs;

  void selectQuality(int value) {
    selectedQuality.value = value;
  }

  final selectedPhoto = 0.obs;

  void selectPhoto(int i) => selectedPhoto.value = i;

  // Provide 5 images (duplicated source for now)
  List<String> get productImages => List.generate(5, (_) => product.imgUrlp);

  // Danh sách subCategory thuộc category được chọn
  final subCategories = <SubCategoryModel>[].obs;
// Mở/đóng các mục kiểm tra
  final RxSet<int> expandedOtherChecks = <int>{}.obs;
  void toggleOtherCheck(int i) {
    if (expandedOtherChecks.contains(i)) {
      expandedOtherChecks.remove(i);
    } else {
      expandedOtherChecks.add(i);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Nhận product ID từ arguments
    final productId = Get.arguments as int;
    _loadProductById(productId);
  }

  void _loadProductById(int productId) {
    print('DetailProductController: loading product with id: $productId');
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Tìm sản phẩm từ mock data
      final foundProduct = _findProductById(productId);

      if (foundProduct != null) {
        product = foundProduct;
        print('DetailProductController: product found: ${product.name}');
        isLoading.value = false;
      } else {
        print('DetailProductController: product not found for id: $productId');
        errorMessage.value = 'Không tìm thấy sản phẩm';
        isLoading.value = false;
      }
    } catch (e) {
      print('DetailProductController: error loading product: $e');
      errorMessage.value = 'Có lỗi xảy ra khi tải sản phẩm';
      isLoading.value = false;
    }
  }

  ProductModel? _findProductById(int id) {
    // Tìm kiếm trong tất cả categories và subcategories
    for (final category in mockCategories) {
      for (final subCategory in category.subCategories) {
        for (final product in subCategory.products) {
          if (product.id == id) {
            return product;
          }
        }
      }
    }
    return null;
  }
}
