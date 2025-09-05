import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/store_model.dart';
import '../services/phone_service.dart';

// i18n
import '../../../core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';

class StoreMapView extends StatefulWidget {
  final StoreModel store;

  const StoreMapView({Key? key, required this.store}) : super(key: key);

  @override
  State<StoreMapView> createState() => _StoreMapViewState();
}

class _StoreMapViewState extends State<StoreMapView> {
  GoogleMapController? _mapController;
  late Set<Marker> _markers;
  late Set<Polyline> _polylines;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _polylines = {};
    _markers = {
      Marker(
        markerId: MarkerId(widget.store.id),
        position: LatLng(widget.store.latitude, widget.store.longitude),
        infoWindow: InfoWindow(
          title: widget.store.name,
          snippet: widget.store.description,
        ),
      ),
    };
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      _currentLocation = LatLng(position.latitude, position.longitude);

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: _currentLocation!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: InfoWindow(title: LocaleKeys.your_location_title.trans()),
          ),
        );
      });

      _showDirectionsOnMap();
    } catch (e) {
      // ignore
    }
  }

  void _showDirectionsOnMap() {
    if (_currentLocation == null) return;

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('directions'),
          points: [
            _currentLocation!,
            LatLng(widget.store.latitude, widget.store.longitude),
          ],
          color: AppColors.primary01,
          width: 4,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.neutral01),
          onPressed: () => Get.back(),
        ),
        title: Text(
          LocaleKeys.store_map_title.trans(),
          style: AppTypography.s16.medium.copyWith(color: AppColors.neutral01),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.directions, color: AppColors.primary01),
            onPressed: _openDirections,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.store.latitude, widget.store.longitude),
                zoom: 16,
              ),
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),
          _buildStoreInfoCard(),
        ],
      ),
    );
  }

  Widget _buildStoreInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.store.name,
                  style: AppTypography.s16.medium.copyWith(color: AppColors.neutral01),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.AS01,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  LocaleKeys.store_open_now.trans(),
                  style: AppTypography.s10.medium.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            widget.store.description,
            style: AppTypography.s14.regular.copyWith(color: AppColors.neutral03),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.access_time, size: 16.sp, color: AppColors.neutral03),
              SizedBox(width: 8.w),
              Text(
                '${LocaleKeys.store_open_hours_prefix.trans()} ${widget.store.openHours}',
                style: AppTypography.s14.regular.copyWith(color: AppColors.neutral03),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.location_on, size: 16.sp, color: AppColors.neutral03),
              SizedBox(width: 8.w),
              Text(
                '${LocaleKeys.store_distance_prefix.trans()} ${widget.store.distance}${LocaleKeys.store_distance_unit.trans()}',
                style: AppTypography.s14.regular.copyWith(color: AppColors.neutral03),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _openDirections,
                  icon: Icon(Icons.directions, size: 18.sp),
                  label: Text(LocaleKeys.store_directions_btn.trans()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary01,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => PhoneService.makePhoneCall(
                    phoneNumber: '0817433226',
                  ),
                  icon: Icon(Icons.phone, size: 18.sp),
                  label: Text(LocaleKeys.store_call_btn.trans()),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary01,
                    side: BorderSide(color: AppColors.primary01),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openDirections() async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=${widget.store.latitude},${widget.store.longitude}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        LocaleKeys.error.trans(),
        LocaleKeys.cannot_open_map_app.trans(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
