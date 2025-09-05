import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/assets/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_store_controller.dart';
import '../../../list_store/controllers/list_store_controller.dart';

class StoreInfoWidget extends GetView<OrderPurchaseAtStoreController> {
  const StoreInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final storeLocation = _getStoreLocation();

      return Scaffold(

        appBar: AppBar(
          title: Text(
            //LocaleKeys.notification_setting.trans(),
            "thu mua tai cua hang",
            style: AppTypography.s20.medium.withColor(AppColors.neutral01),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Get.back(),
          ),
        ),
        body:  GoogleMap(
          initialCameraPosition: CameraPosition(
            target: storeLocation,
            zoom: 16.0,
          ),
          markers: _buildMarkers(storeLocation),
          onMapCreated: (GoogleMapController mapController) {
            controller.mapController = mapController;
            _focusOnStore(mapController);
          },
          onCameraMove: (CameraPosition position) {
            // Handle camera movement for user interaction tracking
          },
          onCameraIdle: () {
            // Camera stopped moving for performance optimization
          },
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: false,
          mapType: MapType.normal,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: 200.h,
          ),
        ),
      );
    });
  }

  Set<Marker> _buildMarkers(LatLng storeLocation) {
    final markers = <Marker>{};
    final store = controller.currentStore.value;

    // Create store location marker with enhanced info
    markers.add(
      Marker(
        markerId: MarkerId('store_location_${store?.id ?? 'default'}'),
        position: storeLocation,
        infoWindow: InfoWindow(
          title: _getStoreName(),
          snippet: _buildMarkerSnippet(store, storeLocation),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () => _onMarkerTapped(store),
      ),
    );

    return markers;
  }

  String _buildMarkerSnippet(dynamic store, LatLng location) {
    final List<String> snippetParts = [];

    // Add store address/district
    snippetParts.add(_getStoreAddress());

    // Add store hours if available
    if (store?.openHours != null) {
      snippetParts.add('⏰ ${store.openHours}');
    }

    // Add services count if available
    if (store?.services != null && store.services.isNotEmpty) {
      snippetParts.add('🛠️ ${store.services.length} dịch vụ');
    }

    // Add distance if available
    if (store?.distance != null && store.distance != '0.0') {
      snippetParts.add('📏 ${store.distance} km');
    }

    return snippetParts.join(' • ');
  }

  void _onMarkerTapped(dynamic store) {
    if (store != null) {
      // Show store details or additional actions
      _showStoreActions(store);
    }
  }

  void _showStoreActions(dynamic store) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store name
            Text(
              store.name ?? 'Cửa hàng',
              style: AppTypography.s16.medium.copyWith(
                color: AppColors.neutral01,
              ),
            ),
            SizedBox(height: 8.h),

            // Store address
            Text(
              store.description ?? '',
              style: AppTypography.s14.regular.copyWith(
                color: AppColors.neutral03,
              ),
            ),
            SizedBox(height: 16.h),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                      controller.focusOnStore();
                    },
                    icon: Icon(Icons.my_location, size: 18.r),
                    label: Text('Định vị'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary01,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.back();
                      // Add call functionality
                    },
                    icon: Icon(Icons.phone, size: 18.r),
                    label: Text('Gọi điện'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary01,
                      side: BorderSide(color: AppColors.primary01),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  LatLng _getStoreLocation() {
    // Priority 1: Get store location from currentStore (loaded from ListStoreController)
    final store = controller.currentStore.value;

    if (store != null) {
      final location = LatLng(store.latitude, store.longitude);
      return location;
    }

    // Priority 2: Try to find store by ID from ListStoreController
    try {
      if (Get.isRegistered<ListStoreController>()) {
        final storeController = Get.find<ListStoreController>();
        final storeId = controller.orderData['storeId'];

        if (storeId != null) {
          final foundStore = storeController.stores.firstWhereOrNull(
            (store) => store.id == storeId,
          );

          if (foundStore != null) {
            return LatLng(foundStore.latitude, foundStore.longitude);
          }
        }

        // If no specific store ID, get first available store
        if (storeController.stores.isNotEmpty) {
          final firstStore = storeController.stores.first;
          return LatLng(firstStore.latitude, firstStore.longitude);
        }
      }
    } catch (e) {
      // If can't access stores, continue to next priority
    }

    // Priority 3: Try direct store coordinates from orderData (fallback)
    final storeLatitude = controller.storeLatitude;
    final storeLongitude = controller.storeLongitude;

    if (storeLatitude != null && storeLongitude != null) {
      final location = LatLng(storeLatitude, storeLongitude);
      return location;
    }

    // Priority 4: Default location (Ho Chi Minh City center) - absolute last resort
    // This should rarely be used now that we prioritize model data
    const defaultLocation = LatLng(10.762622, 106.660172);
    return defaultLocation;
  }

  String _getStoreName() {
    return controller.storeName;
  }

  String _getStoreAddress() {
    return controller.storeAddress;
  }

  void _focusOnStore(GoogleMapController mapController) {
    try {
      final storeLocation = _getStoreLocation();
      final store = controller.currentStore.value;

      // Determine zoom level based on store type or default
      double zoomLevel = 17.0; // Close zoom for store detail
      if (store != null) {
        // Could adjust zoom based on store size, services, etc.
        zoomLevel = store.services.length > 5 ? 16.5 : 17.0;
      }

      // Delay focus to ensure map is fully loaded and stable
      Future.delayed(Duration(milliseconds: 500), () {
        mapController
            .animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: storeLocation,
                  zoom: zoomLevel,
                  bearing: 0.0, // North-facing
                  tilt: 0.0, // Top-down view
                ),
              ),
            )
            .catchError((error) {
              // Handle animation error silently
            });
      });
    } catch (e) {
      // Fallback: try without animation
      try {
        final storeLocation = _getStoreLocation();
        mapController
            .moveCamera(CameraUpdate.newLatLng(storeLocation))
            .catchError((error) {
              // Handle move error silently
            });
      } catch (e2) {
        // Critical error - could show user notification here
      }
    }
  }
}
