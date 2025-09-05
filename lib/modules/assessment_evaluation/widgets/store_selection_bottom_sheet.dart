import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../list_store/controllers/list_store_controller.dart';
import '../../list_store/domain/store_model.dart';

// i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

class StoreSelectionBottomSheet extends StatelessWidget {
  final Function(StoreModel)? onStoreSelected;

  const StoreSelectionBottomSheet({
    super.key,
    this.onStoreSelected,
  });

  @override
  Widget build(BuildContext context) {
    final storeController = Get.find<ListStoreController>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildLocationFilter(storeController),
          Expanded(child: _buildStoreList(storeController)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Text(
            LocaleKeys.store_select_title.trans(),
            style: AppTypography.s18.semibold,
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationFilter(ListStoreController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(Icons.location_on, color: AppColors.primary01),
          SizedBox(width: 8.w),
          Expanded(
            child: Obx(() {
              if (controller.stores.isEmpty) {
                return Text(LocaleKeys.loading_short.trans());
              }

              // Unique districts + "All"
              final uniqueDistricts =
              controller.stores.map((s) => s.district).toSet().toList();
              final locations = [LocaleKeys.filter_all.trans(), ...uniqueDistricts];

              // Normalize selected value to "All" if it is placeholder/nearest
              String normalized = controller.selectedLocation.value;
              if (normalized == LocaleKeys.filter_location_placeholder.trans() ||
                  normalized.startsWith(LocaleKeys.filter_nearest_prefix.trans())) {
                normalized = LocaleKeys.filter_all.trans();
              }
              if (!locations.contains(normalized)) {
                normalized = LocaleKeys.filter_all.trans();
              }

              return DropdownButton<String>(
                value: normalized,
                hint: Text(LocaleKeys.filter_choose_area_hint.trans()),
                isExpanded: true,
                underline: const SizedBox.shrink(),
                items: locations
                    .map(
                      (loc) => DropdownMenuItem(
                    value: loc,
                    child: Text(loc),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  if (value == LocaleKeys.filter_all.trans()) {
                    controller.selectedLocation.value =
                        LocaleKeys.filter_location_placeholder.trans();
                    controller.filteredStores.assignAll(controller.stores);
                  } else {
                    controller.filterByLocation(value);
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreList(ListStoreController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.filteredStores.isEmpty) {
        return Center(
          child: Text(
            LocaleKeys.no_store_found.trans(),
            style: AppTypography.s14.regular.copyWith(color: AppColors.neutral03),
          ),
        );
      }

      return ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: controller.filteredStores.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final store = controller.filteredStores[index];
          return _buildStoreItem(store, controller);
        },
      );
    });
  }

  Widget _buildStoreItem(StoreModel store, ListStoreController controller) {
    return GestureDetector(
      onTap: () {
        onStoreSelected?.call(store);
        Get.back();
        Get.snackbar(
          LocaleKeys.store_selected_title.trans(),
          store.name,
          snackPosition: SnackPosition.TOP,
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.neutral06),
        ),
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.grey.shade300,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  store.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.store, color: Colors.grey.shade600),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: AppTypography.s14.medium,
                    maxLines: 2,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${store.district} • ${store.distance}km',
                    style: AppTypography.s12.regular.copyWith(
                      color: AppColors.neutral03,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () =>
                      controller.makePhoneCall(storeName: store.name),
                  icon: Icon(Icons.phone, color: AppColors.primary01),
                ),
                IconButton(
                  onPressed: () => controller.openDirections(store),
                  icon: Icon(Icons.directions, color: AppColors.primary01),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
