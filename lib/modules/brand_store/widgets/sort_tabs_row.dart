import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../controllers/brand_store_controller.dart';

class SortTabsRow extends GetView<BrandStoreController> {
  const SortTabsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tabText(  LocaleKeys.tab_all.trans(), 0),
            const SizedBox(width: 16),
            _tabText(  LocaleKeys.sort_tabs_models.trans(), 1),
            const SizedBox(width: 16),
            _priceTab(),
            const SizedBox(width: 16),
            _filterTab(),
          ],
        ),
      );
    });
  }

  Widget _tabText(String label, int index) {
    final active = controller.selectedSortTab.value == index;
    return InkWell(
      onTap: () => controller.changeSortTab(index),
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        child: Text(
          label,
          style: (active
              ? AppTypography.s16.semibold.withColor(AppColors.primary01)
              : AppTypography.s16.regular.withColor(AppColors.neutral04)),
        ),
      ),
    );
  }

  Widget _priceTab() {
    final asc = controller.priceAsc.value; // null / true / false
    Color upColor, downColor;
    if (asc == null) {
      upColor = Colors.grey;
      downColor = Colors.grey;
    } else if (asc == true) {
      upColor = Colors.red;
      downColor = Colors.grey;
    } else {
      upColor = Colors.grey;
      downColor = Colors.red;
    }

    return InkWell(
      onTap: controller.togglePriceSort,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Row(
          children: [
             Text(  LocaleKeys.sort_tabs_price.trans(), style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(width: 4),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.keyboard_arrow_up_rounded, size: 16, color: upColor),
                Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: downColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterTab() {
    return InkWell(
      onTap: controller.openFilter,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        child: Row(
          children: const [
            Text('Lọc', style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(width: 6),
            SizedBox(
              width: 20,
              height: 18,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    child: Icon(Icons.filter_alt_outlined, size: 18, color: Colors.grey),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Icon(Icons.search, size: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
