import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/home_pickup_zone_controller.dart';
import '../widgets/booking_button_widget.dart';
import '../widgets/location_dropdown_widget.dart';
import '../widgets/search_field_widget.dart';
import '../widgets/zone_info_widget.dart';

class HomePickupZoneView extends GetView<HomePickupZoneController> {
  const HomePickupZoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: Obx(
            () =>
        controller.isLoading.value
            ? _buildLoadingView()
            : _buildMainContent(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.neutral01),
        onPressed: () => Get.back(),
      ),
      title: Text(
        LocaleKeys.store_near_you.trans(),
        style: AppTypography.s16.medium.copyWith(color: AppColors.neutral01),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(child: CircularProgressIndicator(color: AppColors.primary01));
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        _buildSearchAndFilter(),
        Expanded(
          child: Stack(
              children: [
                _buildMap(),
                ZoneInfoWidget(),
                // ✅ Đặt button ở bottom với SafeArea
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: BookingButtonWidget(),
                  ),
                ),
              ]
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          LocationDropdownWidget(),
          SizedBox(width: 12.w),
          Expanded(child: SearchFieldWidget()),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Obx(
          () =>
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: controller.centerLocation.value,
              zoom: 13,
            ),
            polygons:
            controller.pickupZones
                .map(
                  (zone) =>
                  Polygon(
                    polygonId: PolygonId(zone.id),
                    points: zone.boundaries,
                    fillColor: AppColors.AB01.withOpacity(0.1),
                    strokeColor: AppColors.AB01,
                    strokeWidth: 1,
                    onTap: () => controller.showZoneInfo(zone),
                  ),
            )
                .toSet(),
            markers: controller.markers.value,
            onMapCreated: (GoogleMapController mapController) {
              controller.mapController = mapController;
              controller.getCurrentLocation();
            },
            myLocationEnabled: true,
            // chuc năng hiện vị trí hiện tại
            myLocationButtonEnabled: true,
            // chuc năng hiện nút vị trí hiện tại
            zoomControlsEnabled: false,
            // tắt nút zoom
            mapToolbarEnabled:
            false, // tắt thanh công cụ bản đồ (thanh chứa các nút)
          ),
    );
  }
}
