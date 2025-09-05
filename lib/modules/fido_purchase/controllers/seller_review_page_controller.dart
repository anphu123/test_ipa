import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:get/get.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../domain/seller_review_model.dart';
import '../domain/mock_reviews.dart';

class SellerReviewPageController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  /// Nguồn dữ liệu: chỉ dùng mock đã khai báo
  final RxList<SellerReview> allReviews =
  RxList<SellerReview>.from(sellerReviewsMock);

  /// Tabs khớp với category trong mock_reviews.dart
  final List<String> tabs = [
    LocaleKeys.all.trans(),             // "Tất cả"
    LocaleKeys.phone_category.trans(),  // "Điện thoại"
    LocaleKeys.tablet_category.trans(), // "Tablet"
    LocaleKeys.laptop_category.trans(), // "Laptop"
    LocaleKeys.clock.trans(),           // "Đồng hồ"
    "Thiết bị điện tử",
    "Phụ kiện",
  ];

  /// Danh sách review theo tab đang chọn
  List<SellerReview> get reviews {
    final current = tabs[selectedIndex.value];
    if (current == LocaleKeys.all.trans()) return allReviews;
    return allReviews.where((e) => e.category == current).toList();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  /// Reload lại mock (nếu về sau có cập nhật)
  void refreshReviews() {
    allReviews.assignAll(sellerReviewsMock);
  }
}
