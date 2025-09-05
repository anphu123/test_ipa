import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../router/app_page.dart';
import '../../detail_product/controllers/detail_product_controller.dart';
import '../../detail_product/views/detail_product_screen.dart';
import '../../personal_profile/controllers/personal_profile_controller.dart';
import '../domain/model/category_model.dart';
import '../domain/model/mock_categories.dart';

class HomeController extends GetxController {
  final _storage = GetStorage();
  final isLoggedIn = false.obs;

  final categories = <CategoryModel>[].obs;
  final selectedCategoryId = 0.obs;
  final subCategories = <SubCategoryModel>[].obs;
  final selectedSubCategoryId = RxnInt();
  final filteredProducts = <ProductModel>[].obs;

  final categoryScrollController = ScrollController();
  final categoryItemKeys = <GlobalKey>[];

  final username = ''.obs;

  final bannerImages = [
    Assets.images.bannerXiaomi2.path,
    Assets.images.bannerXiaomi3.path,
    Assets.images.bannerXiaomi4.path,
    Assets.images.bannerXiaomi5.path,
    Assets.images.bannerXiaomi6.path,
  ];

  final pageController = PageController(initialPage: 0);
  final currentPage = 0.obs;
  Timer? _autoScrollTimer;

  @override
  void onInit() {
    super.onInit();
    print('HomeController: onInit called');
    _checkLoginStatus(); // cập nhật trạng thái đăng nhập
    _loadUserData();
    _setupData(); // load dữ liệu cho giao diện
    _startAutoScroll(); // bắt đầu auto scroll banner
    print('HomeController: initialization completed');
  }

  void _checkLoginStatus() {
    print('HomeController: checking login status');
    final loginStatus = _storage.read('isLoggedIn') ?? false;
    isLoggedIn.value = loginStatus;
    print('HomeController: login status from storage: $loginStatus');
    print('HomeController: isLoggedIn set to: ${isLoggedIn.value}');
  }

  Future<void> updateNickname(String newName) async {
    print('HomeController: updating nickname from "${username.value}" to "$newName"');
    username.value = newName;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('nickname', newName);
      print('HomeController: nickname saved to SharedPreferences successfully');
    } catch (e) {
      print('HomeController: error saving nickname to SharedPreferences: $e');
    }
  }

  void _requireLoginIfNeeded(VoidCallback onContinue) {
    print('HomeController: checking if login required');
    if (!isLoggedIn.value) {
      print('HomeController: user not logged in, redirecting to login');
      Get.toNamed(Routes.login);
    } else {
      print('HomeController: user logged in, continuing with action');
      onContinue();
    }
  }

  void requireLogin(VoidCallback onContinue) {
    print('HomeController: requireLogin called');
    if (!isLoggedIn.value) {
      print('HomeController: redirecting to login screen');
      Get.toNamed(Routes.login);
    } else {
      print('HomeController: user authenticated, executing callback');
      onContinue();
    }
  }

  Future<void> _loadUserData() async {
    print('HomeController: loading user data');
    try {
      final prefs = await SharedPreferences.getInstance();
      final nickname = prefs.getString('nickname') ?? 'XiaoYu';
      username.value = nickname;
      print('HomeController: loaded nickname from SharedPreferences: $nickname');
    } catch (e) {
      print('HomeController: error loading user data: $e');
      username.value = 'XiaoYu';
    }
  }

  void _setupData() {
    print('HomeController: setting up data');
    
    final allCategory = CategoryModel(
      id: 0,
      name: {'vi': 'Tất cả', 'en': 'All', 'zh': '全部'},
      subCategories: [],
      imgUrlA: '',
    );
    print('HomeController: created "All" category');

    if (mockCategories.isNotEmpty) {
      print('HomeController: mock categories available, count: ${mockCategories.length}');
      final fidoBoxCategory = mockCategories.firstWhereOrNull((c) => c.id == 1) ?? mockCategories.first;
      print('HomeController: found FidoBox category: ${fidoBoxCategory.name}');
      
      categories.assignAll([
        fidoBoxCategory,
        allCategory,
        ...mockCategories.where((c) => c.id != 1),
      ]);
      print('HomeController: assigned ${categories.length} categories');
    } else {
      print('HomeController: no mock categories available, using only "All" category');
      categories.assignAll([allCategory]);
    }

    categoryItemKeys.clear();
    categoryItemKeys.addAll(List.generate(categories.length, (_) => GlobalKey()));
    print('HomeController: generated ${categoryItemKeys.length} category keys');

    _updateSubCategories();
    selectedSubCategoryId.value = null;
    print('HomeController: reset selected subcategory');
    _updateProducts();
    print('HomeController: data setup completed');
  }

  void _startAutoScroll() {
    print('HomeController: starting auto scroll timer');
    _autoScrollTimer?.cancel(); // Cancel existing timer if any
    _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (_) {
      final nextPage = (currentPage.value + 1) % bannerImages.length;
      print('HomeController: auto scrolling from page ${currentPage.value} to $nextPage');
      pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage.value = nextPage;
    });
    print('HomeController: auto scroll timer started');
  }

  void onPageChanged(int index) {
    print('HomeController: page changed to index: $index');
    currentPage.value = index;
  }

  void selectCategory(int id) {
    print('HomeController: category selection requested for id: $id');
    _requireLoginIfNeeded(() {
      if (selectedCategoryId.value != id) {
        print('HomeController: changing category from ${selectedCategoryId.value} to $id');
        selectedCategoryId.value = id;
        selectedSubCategoryId.value = null;
        print('HomeController: reset subcategory selection');
        _updateSubCategories();
        _updateProducts();
      } else {
        print('HomeController: category $id already selected');
      }

      _scrollToCategoryItem(id);
    });
  }

  void selectSubCategory(int? id) {
    print('HomeController: subcategory selection requested for id: $id');
    _requireLoginIfNeeded(() {
      if (selectedSubCategoryId.value != id) {
        print('HomeController: changing subcategory from ${selectedSubCategoryId.value} to $id');
        selectedSubCategoryId.value = id;
        _updateProducts();
      } else {
        print('HomeController: subcategory $id already selected');
      }
    });
  }

  void goToProductDetail(int productId) {
    print('HomeController: navigating to product detail for id: $productId');
    _requireLoginIfNeeded(() {
      print('HomeController: passing product ID: $productId to DetailProductScreen');
      Get.to(
        () => const DetailProductScreen(),
        arguments: productId, // Chỉ truyền ID thay vì toàn bộ product
        binding: BindingsBuilder(() {
          Get.lazyPut<DetailProductController>(() => DetailProductController());
        }),
      );
      print('HomeController: navigated to product detail screen');
    });
  }

  ProductModel? getProductById(int id) {
    print('HomeController: searching for product with id: $id');
    final product = categories
        .where((c) => c.id != 0)
        .expand((c) => c.subCategories)
        .expand((sc) => sc.products)
        .firstWhereOrNull((p) => p.id == id);
    
    if (product != null) {
      print('HomeController: product found: ${product.name}');
    } else {
      print('HomeController: product not found for id: $id');
    }
    return product;
  }

  void _updateSubCategories() {
    print('HomeController: updating subcategories for category: ${selectedCategoryId.value}');
    if (selectedCategoryId.value == 0) {
      print('HomeController: "All" category selected, loading all subcategories');
      subCategories.value = mockCategories
          .where((c) => c.id != 0)
          .expand((c) => c.subCategories)
          .toList();
    } else {
      final category = mockCategories.firstWhereOrNull((c) => c.id == selectedCategoryId.value);
      if (category != null) {
        print('HomeController: category found, loading ${category.subCategories.length} subcategories');
        subCategories.value = category.subCategories;
      } else {
        print('HomeController: category not found, clearing subcategories');
        subCategories.value = [];
      }
    }
    print('HomeController: subcategories updated, count: ${subCategories.length}');
  }

  void _updateProducts() {
    print('HomeController: updating products');
    print('HomeController: selected category: ${selectedCategoryId.value}, selected subcategory: ${selectedSubCategoryId.value}');
    
    if (selectedCategoryId.value == 0) {
      print('HomeController: loading all products from all categories');
      filteredProducts.value = categories
          .where((c) => c.id != 0 && c.id != 1)
          .expand((c) => c.subCategories)
          .expand((sc) => sc.products)
          .toList();
    } else if (selectedSubCategoryId.value == null) {
      print('HomeController: loading all products from selected category');
      filteredProducts.value = subCategories.expand((sc) => sc.products).toList();
    } else {
      print('HomeController: loading products from selected subcategory');
      final subCategory = subCategories.firstWhereOrNull((sc) => sc.id == selectedSubCategoryId.value);
      if (subCategory != null) {
        filteredProducts.value = subCategory.products;
        print('HomeController: loaded ${subCategory.products.length} products from subcategory: ${subCategory.name}');
      } else {
        print('HomeController: subcategory not found, clearing products');
        filteredProducts.value = [];
      }
    }
    print('HomeController: products updated, count: ${filteredProducts.length}');
  }

  void _scrollToCategoryItem(int id) {
    print('HomeController: scrolling to category item with id: $id');
    final index = categories.indexWhere((c) => c.id == id);
       if (index != -1 && index < categoryItemKeys.length) {
      print('HomeController: category found at index: $index');
      final key = categoryItemKeys[index];
      final context = key.currentContext;
      if (context != null) {
        print('HomeController: calculating scroll position for category');
        final box = context.findRenderObject() as RenderBox;
        final itemPosition = box.localToGlobal(Offset.zero);
        final itemWidth = box.size.width;
        final screenWidth = Get.width;
        
        print('HomeController: item position: ${itemPosition.dx}, width: $itemWidth, screen width: $screenWidth');

        if (itemPosition.dx < 0) {
          print('HomeController: item is off-screen left, scrolling left');
          categoryScrollController.animateTo(
            categoryScrollController.offset + itemPosition.dx,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else if (itemPosition.dx + itemWidth > screenWidth) {
          print('HomeController: item is off-screen right, scrolling right');
          final offset = itemPosition.dx + itemWidth - screenWidth;
          final targetOffset = (categoryScrollController.offset + offset)
              .clamp(0.0, categoryScrollController.position.maxScrollExtent);

          categoryScrollController.animateTo(
            targetOffset,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          print('HomeController: item is already visible, no scrolling needed');
        }
      } else {
        print('HomeController: category context not found for index: $index');
      }
    } else {
      print('HomeController: category not found or invalid index: $index');
    }
  }

  void pauseAutoScroll() {
    print('HomeController: pausing auto scroll');
    _autoScrollTimer?.cancel();
  }

  void resumeAutoScroll() {
    print('HomeController: resuming auto scroll');
    _startAutoScroll();
  }

  @override
  void onClose() {
    print('HomeController: onClose called');
    _autoScrollTimer?.cancel();
    print('HomeController: auto scroll timer cancelled');
    pageController.dispose();
    print('HomeController: page controller disposed');
    categoryScrollController.dispose();
    print('HomeController: category scroll controller disposed');
    super.onClose();
    print('HomeController: cleanup completed');
  }

  String getTranslatedCategoryName(Map<String, String> names) {
    final lang = Get.locale?.languageCode ?? 'vi';
    final translatedName = names[lang] ?? names['vi'] ?? '';
    print('HomeController: translating category name for language "$lang": $translatedName');
    return translatedName;
  }

  String getTranslatedSubCategoryName(Map<String, String> names) {
    final lang = Get.locale?.languageCode ?? 'vi';
    final translatedName = names[lang] ?? names['vi'] ?? '';
    print('HomeController: translating subcategory name for language "$lang": $translatedName');
    return translatedName;
  }
}