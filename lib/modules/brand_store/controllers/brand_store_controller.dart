import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';

class BrandStoreController extends GetxController {
  // ---- Brand + ảnh fallback ----
  late final dynamic brand;
  final fallbackLogo =
      'https://upload.wikimedia.org/wikipedia/commons/2/29/Xiaomi_logo.svg';
  final fallbackBanner =
      'https://scontent.fsgn5-5.fna.fbcdn.net/v/t39.30808-6/515149051_1157109836446402_8239218789379511631_n.png?_nc_cat=100&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=D2jC5rNLh3wQ7kNvwFQzOPS&_nc_oc=AdkT1UnjmaNTzGm7_LwuQgTk3q-EQ0jC1jqQ7jiPmYq6NSGMxp1geJSS3yvqjkkxuAne0b7qJLp_01GhE2-SePHr&_nc_zt=23&_nc_ht=scontent.fsgn5-5.fna&_nc_gid=XZUlqG5Klgaku4kObMlDgA&oh=00_AfWzrSFGUOq_--woxWTK-OneFrqhi-ZoKARDmKJhRg9fnw&oe=68A0C4A3';

  // ---- Sub-cat (icon sản phẩm tiêu biểu) ----
  final subCats = <Map<String, String>>[
    {
      'icon':
      'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi_14t_pro_1_.png',
      'name': 'Xiaomi 14T'
    },
    {
      'icon':
      'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-redmi-note-14.png',
      'name': 'Redmi Note 14'
    },
    {
      'icon':
      'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-15-ultra.png',
      'name': 'Xiaomi 15 Ultra'
    },
    {
      'icon':
      'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-13t_1__1_2.png',
      'name': 'Xiaomi 13T'
    },
    {
      'icon':
      'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-poco-x7-pro-5g_2_.png',
      'name': 'POCO X7 Pro'
    },
  ].obs;

  // ==== STATE CHO TAB ====
  final tabs = <String>[ LocaleKeys.sort_tabs_all.trans(),   LocaleKeys.tab_phone.trans(),   LocaleKeys.tab_earphone.trans(),   LocaleKeys.tab_vacuum.trans(),   LocaleKeys.tab_watch.trans(),].obs;

  /// Tab chính (đỏ + gạch dưới)
  final selectedMainTab = 0.obs;

  /// Hàng “Tổng hợp | Mẫu sản phẩm | Giá cả | Lọc”
  /// 0: Tổng hợp, 1: Mẫu sản phẩm (chỉ đổi màu – không lọc dữ liệu)
  final selectedSortTab = 0.obs;

  /// sub model (nếu bạn muốn dùng sau)
  final selectedSubTab = (-1).obs;

  // ---- Filter chips demo ----
  final filters = <String>[  LocaleKeys.filter_price_range.trans(),   LocaleKeys.filter_size.trans(),  LocaleKeys.filter_promotion.trans(),   LocaleKeys.filter_discount.trans()].obs;

  // ---- Giá ↑↓ ----
  final RxnBool priceAsc = RxnBool(null);

  // ---- Dữ liệu sản phẩm ----
  final products = <Map<String, dynamic>>[].obs; // list hiển thị
  late final List<Map<String, dynamic>> _allProducts; // dữ liệu gốc

  // ==== ACTIONS ====
  void changeMainTab(int i) => selectedMainTab.value = i;
  void changeSortTab(int i) => selectedSortTab.value = i;
  void changeSubTab(int i) => selectedSubTab.value = (selectedSubTab.value == i) ? -1 : i;

  void togglePriceSort() {
    priceAsc.value = (priceAsc.value == null) ? true : !(priceAsc.value!);
  }

  void openFilter() {
    Get.snackbar(  LocaleKeys.filter.trans(),   LocaleKeys.filter_open_demo.trans(),);
  }

  @override
  void onInit() {
    super.onInit();
    brand = Get.arguments;

    final name = (brand?.name ?? 'Xiaomi').toString();
    _allProducts = _buildMockProducts(name);

    // Lắng nghe những state ảnh hưởng tới LIST (tab chính + sort theo giá)
    everAll([selectedMainTab, priceAsc], (_) => _applyCurrentFilters());

    _applyCurrentFilters();
  }

  // ==== FILTER + SORT CHO LIST ====
  void _applyCurrentFilters() {
    final tabLabel = tabs[selectedMainTab.value];

    // 1) lọc theo tab chính
    List<Map<String, dynamic>> list = (tabLabel == LocaleKeys.sort_tabs_all.trans())
        ? List.of(_allProducts)
        : _allProducts.where((e) => e['cat'] == tabLabel).toList();

    // 2) sort theo giá nếu có
    final asc = priceAsc.value;
    if (asc != null) {
      list.sort((a, b) => asc
          ? (a['price'] as num).compareTo(b['price'] as num)
          : (b['price'] as num).compareTo(a['price'] as num));
    }

    products.assignAll(list);
  }

  // ==== MOCK DATA ====
  List<Map<String, dynamic>> _buildMockProducts(String brandName) {
    final phones = <Map<String, dynamic>>[
      _p(
        cat:   LocaleKeys.tab_phone.trans(),
        name: '$brandName 15 Ultra 5G 16GB',
        image:
        'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-15-ultra.png',
        variant: '512GB • Phiên bản Màu trắng',
        desc: 'Khung kim loại • chip mạnh • camera tele.',
        price: 80000000,
        original: 186000000,
        tag: '99% like new',
      ),
      _p(
        cat:   LocaleKeys.tab_phone.trans(),
        name: '$brandName 14T Pro 12GB',
        image:
        'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi_14t_pro_1_.png',
        variant:   LocaleKeys.variant_fast_charge.trans(),
        desc:   LocaleKeys.desc_phone_2.trans(),
        price: 13990000,
        original: 16990000,
        tag: 'Mới 100%',
      ),
      _p(
        cat:   LocaleKeys.tab_phone.trans(),
        name: 'Redmi Note 14 8GB',
        image:
        'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-xiaomi-redmi-note-14.png',
        variant:   LocaleKeys.variant_fast_charge.trans(),
        desc:   LocaleKeys.desc_phone_2.trans(),
        price: 6990000,
        original: 7990000,
        tag: 'Flash Sale',
      ),
      _p(
        cat:   LocaleKeys.tab_phone.trans(),
        name: 'POCO X7 Pro 12GB',
        image:
        'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/d/i/dien-thoai-poco-x7-pro-5g_2_.png',
        variant:   LocaleKeys.variant_fast_charge.trans(),
        desc:   LocaleKeys.desc_phone_2.trans(),
        price: 8990000,
        original: 10990000,
        tag: 'Hot',
      ),
    ];

    final buds = <Map<String, dynamic>>[
      _p(
        cat:   LocaleKeys.tab_earphone.trans(),
        name: 'Xiaomi Buds 5 Pro',
        image: 'https://cdn.tgdd.vn/Products/Images/54/321171/tai-nghe-bluetooth-true-wireless-xiaomi-redmi-buds-5-pro-1-750x500.jpg',
        variant:   LocaleKeys.variant_fast_charge.trans(),
        desc:   LocaleKeys.desc_phone_2.trans(),
        price: 1990000,
        original: 2490000,
        tag: 'Ưu đãi',
      ),
      _p(
        cat:   LocaleKeys.tab_earphone.trans(),
        name: 'Redmi Buds 6',
        image: 'https://cdn.tgdd.vn/Products/Images/54/328697/tai-nghe-bluetooth-tws-xiaomi-redmi-buds-6-lite-200824-041041-600x600.jpg',
        variant:   LocaleKeys.variant_fast_charge.trans(),
        desc:   LocaleKeys.desc_phone_2.trans(),
        price: 690000,
        original: 890000,
      ),
    ];

    final vac = <Map<String, dynamic>>[
      _p(
        cat:   LocaleKeys.tab_vacuum.trans(),
        name: 'Xiaomi Robot Vacuum S10+',
        image: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/r/o/robot_hut_bui_kh_ng_dock.png',
        variant:   LocaleKeys.variant_fast_charge.trans(),
        desc:   LocaleKeys.desc_phone_2.trans(),
        price: 7990000,
        original: 9990000,
        tag: 'Trợ giá',
      ),
      _p(
        cat:   LocaleKeys.tab_vacuum.trans(),
        name: 'Dreame H12',
        image: 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/r/o/robot-hut-bui-xiaomi-x20-max_1_.1.png',
        variant:   LocaleKeys.variant_fast_charge.trans(),
        desc:   LocaleKeys.desc_phone_2.trans(),
        price: 3690000,
        original: 4490000,
      ),
    ];

    final watch = <Map<String, dynamic>>[
      _p(
        cat:   LocaleKeys.tab_watch.trans(),
        name: 'Xiaomi Watch S3',
        image: 'https://cdn.tgdd.vn/Products/Images/7077/321817/xiaomi-watch-s-3-bac-1-1-750x500.jpg',
        variant:   LocaleKeys.variant_fast_charge.trans(),
        desc:   LocaleKeys.desc_phone_2.trans(),
        price: 2990000,
        original: 3490000,
        tag: 'Mới',
      ),
      _p(
        cat:   LocaleKeys.tab_watch.trans(),
        name: 'Redmi Watch 4',
        image: 'https://cdn.tgdd.vn/Products/Images/7077/320842/dong-ho-thong-minh-xiaomi-redmi-watch-4-47-5mm-day-silicone-090124-114101-1-600x600.jpg',
        variant:   LocaleKeys.variant_fast_charge.trans(),
        desc:   LocaleKeys.desc_phone_2.trans(),
        price: 1890000,
        original: 2190000,
      ),
    ];

    return [...phones, ...buds, ...vac, ...watch];
  }

  Map<String, dynamic> _p({
    required String cat,
    required String name,
    required String image,
    required String variant,
    required String desc,
    required int price,
    required int original,
    String? tag,
  }) {
    final discountPercent = (100 - (price * 100 / original)).round().clamp(0, 100);
    return {
      'cat': cat,
      'name': name,
      'image': image,
      'variant': variant,
      'desc': desc,
      'price': price,
      'originalPrice': original,
      'discountPercent': discountPercent,
      'tag': tag ?? '',
      'rating': 4.7,
      'sold': 128,
      'badge':     LocaleKeys.badge_fast_delivery.trans(),

      // optional for UI:
      'condition': 95,
      'grade': 'S',
    };
  }

  // ---- Utils ----
  String formatCurrency(num v) {
    final s = v.toStringAsFixed(0);
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final idx = s.length - i;
      buf.write(s[i]);
      if (idx > 1 && idx % 3 == 1) buf.write('.');
    }
    return buf.toString();
  }

  String get brandName => (brand?.name ?? 'Xiaomi').toString();
  String get brandLogo => (brand?.logoUrl ?? brand?.logo ?? fallbackLogo).toString();
  String get brandBanner => (brand?.bannerUrl ?? brand?.heroUrl ?? fallbackBanner).toString();
  int get productCount => _allProducts.length;
}
