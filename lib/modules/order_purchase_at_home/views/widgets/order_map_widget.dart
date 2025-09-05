import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../controllers/order_purchase_at_home_controller.dart';

class OrderMapWidget extends GetView<OrderPurchaseAtHomeController> {
  const OrderMapWidget({super.key});

  // Cache for custom icons
  static BitmapDescriptor? _customerIcon;
  static BitmapDescriptor? _shipperIcon;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Default location (Ho Chi Minh City center)
      const defaultLocation = LatLng(10.762622, 106.660172);

      // Get coordinates from address using controller method
      final location = controller.getLocationFromAddress(controller.customerAddress) ?? defaultLocation;

      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: location,
          zoom: 14.0, // Zoom out một chút để thấy cả route
        ),
        markers: _buildMarkers(location),
        polylines: _buildPolylines(location),
        onMapCreated: (GoogleMapController mapController) {
          controller.setMapController(mapController);
          _fitMapToShowRoute(mapController, location);
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
      );
    });
  }

  Set<Marker> _buildMarkers(LatLng customerLocation) {
    final markers = <Marker>{};

    // Customer location marker
    markers.add(
      Marker(
        markerId: MarkerId('customer_location'),
        position: customerLocation,
        infoWindow: InfoWindow(
          title: 'Địa chỉ khách hàng',
          snippet: controller.customerAddress,
        ),
        icon: _getCustomerIcon(),
      ),
    );

    // Shipper location marker
    final shipper = controller.shipper.value;
    if (shipper != null) {
      markers.add(
        Marker(
          markerId: MarkerId('shipper_location'),
          position: LatLng(shipper.latitude, shipper.longitude),
          infoWindow: InfoWindow(
            title: 'Shipper: ${shipper.name}',
            snippet: '${shipper.vehicleType} • ${shipper.estimatedArrival}',
          ),
          icon: _getShipperIcon(),
        ),
      );
    }

    return markers;
  }

  // Get custom customer icon
  BitmapDescriptor _getCustomerIcon() {
    if (_customerIcon != null) return _customerIcon!;

    // Fallback to default icon while loading custom icon
    _loadCustomerIcon();
    return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }

  // Get custom shipper icon
  BitmapDescriptor _getShipperIcon() {
    if (_shipperIcon != null) return _shipperIcon!;

    // Fallback to default icon while loading custom icon
    _loadShipperIcon();
    return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  }

  // Load custom customer icon
  void _loadCustomerIcon() async {
    if (_customerIcon != null) return;

    try {
      _customerIcon = await _createCustomMarkerIcon(
        assetPath: Assets.images.icHome.path,
        color: Colors.red,
        backgroundColor: Colors.white,
        size: 50,
      );
    } catch (e) {
      // Keep default icon if custom icon fails
      _customerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  // Load custom shipper icon
  void _loadShipperIcon() async {
    if (_shipperIcon != null) return;

    try {
      _shipperIcon = await _createCustomMarkerIcon(
        assetPath: Assets.images.logoHome.path, // Sử dụng asset path
        color: AppColors.primary01,
        backgroundColor: AppColors.primary01, // Không có background
        size: 50,
      );
    } catch (e) {
      // Keep default icon if custom icon fails
      _shipperIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    }
  }

  Set<Polyline> _buildPolylines(LatLng customerLocation) {
    final polylines = <Polyline>{};
    final shipper = controller.shipper.value;

    if (shipper != null) {
      final shipperLocation = LatLng(shipper.latitude, shipper.longitude);

      // Tạo route giả từ shipper đến khách hàng
      final routePoints = _generateRoutePoints(shipperLocation, customerLocation);

      polylines.add(
        Polyline(
          polylineId: PolylineId('shipper_route'),
          points: routePoints,
          color: Colors.blue,
          width: 4,
          patterns: [PatternItem.dash(20), PatternItem.gap(10)], // Đường đứt nét
        ),
      );
    }

    return polylines;
  }

  List<LatLng> _generateRoutePoints(LatLng start, LatLng end) {
    // Tạo route giả với một số điểm trung gian để mô phỏng đường đi thực tế
    final points = <LatLng>[];

    points.add(start);

    // Thêm một số điểm trung gian để tạo đường cong tự nhiên
    final midLat = (start.latitude + end.latitude) / 2;
    final midLng = (start.longitude + end.longitude) / 2;

    // Điểm trung gian 1 (hơi lệch để tạo đường cong)
    points.add(LatLng(
      start.latitude + (midLat - start.latitude) * 0.3,
      start.longitude + (midLng - start.longitude) * 0.5,
    ));

    // Điểm trung gian 2
    points.add(LatLng(
      start.latitude + (midLat - start.latitude) * 0.7,
      start.longitude + (midLng - start.longitude) * 0.8,
    ));

    points.add(end);

    return points;
  }

  void _fitMapToShowRoute(GoogleMapController mapController, LatLng customerLocation) {
    final shipper = controller.shipper.value;
    if (shipper != null) {
      final shipperLocation = LatLng(shipper.latitude, shipper.longitude);

      // Tính toán bounds để hiển thị cả shipper và customer
      final bounds = _calculateBounds([shipperLocation, customerLocation]);

      // Fit map để hiển thị cả 2 điểm với padding
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 100.0),
      );
    }
  }

  LatLngBounds _calculateBounds(List<LatLng> points) {
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final point in points) {
      minLat = math.min(minLat, point.latitude);
      maxLat = math.max(maxLat, point.latitude);
      minLng = math.min(minLng, point.longitude);
      maxLng = math.max(maxLng, point.longitude);
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  // Create custom marker icon from IconData
  Future<BitmapDescriptor> _createCustomMarkerIcon({
   // required IconData? icon,
    required String? assetPath,
    required Color? color,
    required Color? backgroundColor,
    required double size,
  }) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final radius = size / 2;

    // Draw circle background only if backgroundColor is provided
    if (backgroundColor != null) {
      final paint = Paint()..color = backgroundColor;
      canvas.drawCircle(
        Offset(radius, radius),
        radius,
        paint,
      );
    }

    // Draw border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(
      Offset(radius, radius),
      radius - 1.5,
      borderPaint,
    );

    // Draw icon or asset image
     if (assetPath != null) {
      // Draw asset image
      try {
        final ByteData data = await rootBundle.load(assetPath);
        final ui.Codec codec = await ui.instantiateImageCodec(
          data.buffer.asUint8List(),
          targetWidth: (size * 0.6).round(),
          targetHeight: (size * 0.6).round(),
        );
        final ui.FrameInfo frameInfo = await codec.getNextFrame();
        final ui.Image assetImage = frameInfo.image;

        canvas.drawImage(
          assetImage,
          Offset(
            (size - assetImage.width) / 2,
            (size - assetImage.height) / 2,
          ),
          Paint(),
        );
      } catch (e) {
        // Fallback to a simple circle if color is provided
        if (color != null) {
          final fallbackPaint = Paint()..color = color;
          canvas.drawCircle(
            Offset(radius, radius),
            radius * 0.3,
            fallbackPaint,
          );
        }
      }
    }

    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(size.round(), size.round());
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.bytes(bytes!.buffer.asUint8List());
  }


}
