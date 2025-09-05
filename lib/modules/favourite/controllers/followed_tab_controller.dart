import 'package:get/get.dart';
import '../domain/favourite_product_model.dart';
import '../domain/mock_favourite_data.dart';

class FollowedTabController extends GetxController {
  /// Danh sách tất cả sản phẩm đang theo dõi
  final products = <FavouriteProductModel>[].obs;

  /// Bộ lọc (dùng trong tương lai)
  final selectedCategory = ''.obs;
  final selectedBrand = ''.obs;
  final selectedSeries = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadMockData(); // sau này có thể thay bằng loadFromApi()
  }

  /// Load mock data từ local (fake API)
  void loadMockData() {
    products.assignAll(mockFavouriteProducts);
  }

  /// Lấy danh sách category duy nhất
  List<String> get categoryList =>
      products.map((e) => e.category).toSet().toList();

  /// Lấy danh sách brand duy nhất
  List<String> get brandList =>
      products.map((e) => e.brand).toSet().toList();

  /// Lấy danh sách series duy nhất
  List<String> get seriesList =>
      products.map((e) => e.series).toSet().toList();

  /// Lọc sản phẩm theo category (có thể mở rộng theo brand/series)
  List<FavouriteProductModel> getProductsByCategory(String category) {
    return products.where((e) => e.category == category).toList();
  }

  /// Sau này thêm hàm loadFromApi nếu cần:
  Future<void> loadFromApi() async {
    // TODO: fetch từ API bằng Dio/GetConnect
    // final result = await ApiService.get('/favourites');
    // products.assignAll(result.data);
  }
}
