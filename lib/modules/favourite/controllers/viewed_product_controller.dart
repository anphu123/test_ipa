import 'package:get/get.dart';
import '../domain/viewed_product_model.dart';
import '../domain/mock_viewed_data.dart';
import 'package:intl/intl.dart';

class ViewedProductController extends GetxController {
  final viewedProducts = <ViewedProductModel>[].obs;
  final groupedByDate = <String, List<ViewedProductModel>>{}.obs;
  final selectedIds = <String>{}.obs;
  final selectionMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    viewedProducts.assignAll(mockViewedProducts);
    _groupProductsByDate();
  }

  void toggleSelection(String id) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
  }

  bool isSelected(String id) => selectedIds.contains(id);
  void deleteAll() {
  viewedProducts.clear();
  selectedIds.clear();
  if (selectionMode.value) {
    selectionMode.value = false;
  }
  _groupProductsByDate(); // Update the grouped products after clearing
}
  void deleteSelected() {
    viewedProducts.removeWhere((p) => selectedIds.contains(p.id));
    selectedIds.clear();
    _groupProductsByDate();
    selectionMode.value = false;
  }

  void toggleSelectionMode() {
    selectionMode.value = !selectionMode.value;
    if (!selectionMode.value) selectedIds.clear();
  }

  void _groupProductsByDate() {
    final Map<String, List<ViewedProductModel>> grouped = {};
    for (var product in viewedProducts) {
      final key = _formatDate(product.viewedAt);
      grouped.putIfAbsent(key, () => []).add(product);
    }
    final sorted = Map.fromEntries(
      grouped.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key)),
    );
    groupedByDate.assignAll(sorted);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final viewed = DateTime(date.year, date.month, date.day);

    if (viewed == today) return "Hôm nay";
    if (viewed == today.subtract(Duration(days: 1))) return "Hôm qua";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}
