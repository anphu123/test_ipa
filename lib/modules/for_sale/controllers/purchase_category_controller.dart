// import 'package:get/get.dart';
//
// import '../domain/for_sale_brand_model.dart';
// import '../domain/for_sale_category.dart';
//
//
// class PurchaseCategoryController extends GetxController {
//   // Use RxInt to make categoryId reactive
//   var categoryId = 1.obs; // Default categoryId as 1, for example
//
//   PurchaseCategoryController({required int categoryId}) {
//     this.categoryId.value = categoryId;
//   }
//
//   // List of all categories
//   final List<ForSaleCategory> categories = [
//     ForSaleCategory(id: 1, name: "Điện thoại"),
//     ForSaleCategory(id: 2, name: "Laptop"),
//     ForSaleCategory(id: 3, name: "Tai nghe"),
//     ForSaleCategory(id: 4, name: "Đồng hồ"),
//     ForSaleCategory(id: 5, name: "Thiết bị kỹ thuật số"),
//     ForSaleCategory(id: 6, name: "Máy ảnh/ Máy quay"),
//     ForSaleCategory(id: 7, name: "Thiết bị máy tính"),
//     ForSaleCategory(id: 8, name: "Hàng xa xỉ"),
//     ForSaleCategory(id: 9, name: "Sách"),
//     ForSaleCategory(id: 10, name: "Đồ dùng văn phòng"),
//     ForSaleCategory(id: 11, name: "Điện gia dụng"),
//   ];
//
//   // List of all brands
//   final List<ForSaleBrandModel> brands = [
//     ForSaleBrandModel(id: 1, name: "Apple", categoryId: 1),
//     ForSaleBrandModel(id: 2, name: "Honor", categoryId: 1),
//     ForSaleBrandModel(id: 3, name: "Huawei", categoryId: 2),
//     ForSaleBrandModel(id: 4, name: "OnePlus", categoryId: 2),
//     ForSaleBrandModel(id: 5, name: "OPPO", categoryId: 3),
//     ForSaleBrandModel(id: 6, name: "Redmi", categoryId: 3),
//     ForSaleBrandModel(id: 7, name: "Realme", categoryId: 4),
//     ForSaleBrandModel(id: 8, name: "Samsung", categoryId: 4),
//     ForSaleBrandModel(id: 9, name: "Vivo", categoryId: 5),
//     ForSaleBrandModel(id: 10, name: "Xiaomi", categoryId: 5),
//   ];
//
//   // Get the selected category name based on categoryId
//   String get selectedCategoryName {
//     return categories.firstWhere((category) => category.id == categoryId.value).name;
//   }
//
//   // Get filtered brands based on the categoryId
//   List<ForSaleBrandModel> get filteredBrands {
//     return brands.where((brand) => brand.categoryId == categoryId.value).toList();
//   }
//
//   // Search filtered brands based on query
//   List<ForSaleBrandModel> searchBrands(String query) {
//     return filteredBrands
//         .where((brand) => brand.name.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// }
