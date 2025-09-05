import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../domain/brand_model.dart';

class CategoryFidoPurchaseController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final ScrollController scrollController = ScrollController();
  final List<CategoryModel> data;
  CategoryFidoPurchaseController(this.data);

  final RxList<String> categories = <String>[].obs;
  final Map<int, String> bannerImages = {};
  final Map<int, String> featuredProductName = {};
  final Map<int, String> featuredProductImage = {};
  final Map<int, String> featuredProductPrice = {};
  final Map<int, List<BrandModel>> brandByCategory = {};
  final Map<int, List<String>> popularModelsByCategory = {};

// Search functionality
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;
  final RxList<String> searchResults = <String>[].obs;
  final RxList<String> searchSuggestions = <String>[].obs;

  void startSearch() {
    isSearching.value = true;
  }

  void stopSearch() {
    isSearching.value = false;
    searchQuery.value = '';
    searchResults.clear();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.clear();
      searchSuggestions.clear();
      return;
    }
    _performSearch(query);
  }

   void _performSearch(String query) {
    print('🔍 Starting search for query: "$query"');
    
    final results = <String>[];
    final suggestions = <String>[];

    // Search in categories
    print('📂 Searching in categories...');
    for (final category in categories) {
      if (category.toLowerCase().contains(query.toLowerCase())) {
        results.add(category);
        print('✅ Found category: $category');
      }
    }

    // Search in brands
    print('🏷️ Searching in brands...');
    for (final brands in brandByCategory.values) {
      for (final brand in brands) {
        if (brand.name.toLowerCase().contains(query.toLowerCase())) {
          results.add(brand.name);
          suggestions.add(brand.name);
          print('✅ Found brand: ${brand.name}');
        }
      }
    }

    // Search in popular models
    print('📱 Searching in popular models...');
    for (final models in popularModelsByCategory.values) {
      for (final model in models) {
        if (model.toLowerCase().contains(query.toLowerCase())) {
          results.add(model);
          suggestions.add(model);
          print('✅ Found model: $model');
        }
      }
    }

    final uniqueResults = results.toSet().toList();
    final uniqueSuggestions = suggestions.toSet().take(5).toList();

    searchResults.assignAll(uniqueResults);
    searchSuggestions.assignAll(uniqueSuggestions);

    print('📊 Search completed!');
    print('📋 Total results found: ${uniqueResults.length}');
    print('📝 Results: $uniqueResults');
    print('💡 Suggestions: $uniqueSuggestions');
    print('─' * 50);
  }

  void selectSearchResult(String result) {
    // Handle search result selection
    searchQuery.value = result;
    stopSearch();
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['id'] != null) {
      selectedIndex.value = args['id'];
    }
    for (final item in data) {
      categories.add(item.name);
      bannerImages[item.id] = item.bannerImage;
      featuredProductName[item.id] = item.featuredProductName!;
      featuredProductImage[item.id] = item.featuredProductImage ?? '';
      featuredProductPrice[item.id] = item.featuredProductPrice!;
      brandByCategory[item.id] = item.brands;
      popularModelsByCategory[item.id] = item.popularModels;
    }
  }
}
