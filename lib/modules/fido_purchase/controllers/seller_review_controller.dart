import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:get/get.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../domain/seller_review_model.dart';
import '../domain/mock_reviews.dart';

class SellerReviewController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<String> tabs = [
    LocaleKeys.all.trans(),
   // "Điện thoại",
    LocaleKeys.phone_category.trans(),
   // "Tablet",
    LocaleKeys.tablet_category.trans(),
    //"Laptop",
    LocaleKeys.laptop_category.trans(),
    //"Đồng hồ",
    LocaleKeys.clock.trans(),
    "Thiết bị điện tử",
   // LocaleKeys.sell_now_description.trans(),
    //"Phụ kiện",
    LocaleKeys.sell_now_description.trans(),
  ];

  List<SellerReview> get reviews {
    final selectedTab = tabs[selectedIndex.value];
    if (selectedTab == LocaleKeys.all.trans()) return sellerReviewsMock;
    return sellerReviewsMock.where((e) => e.category == selectedTab).toList();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
