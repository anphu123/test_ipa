import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/shipper_model.dart';

class OrderPurchaseAtHomeController extends GetxController {
  // Order data received from arguments
  final orderData = <String, dynamic>{}.obs;
  final orderId = ''.obs;
  final orderCreatedAt = Rxn<DateTime>();

  // Order status
  final orderStatus = 'waiting_confirmation'.obs; // waiting_confirmation, on_the_way, completed

  // Loading states
  final isLoading = false.obs;
  final isConfirming = false.obs;

  // Shipper information
  final shipper = Rxn<ShipperModel>();

  // Google Maps controller
  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();

    // Get order data from arguments
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      orderData.value = arguments;
      print('📦 OrderPurchaseController initialized with data:');
      print('Customer: ${orderData['contactName']} - ${orderData['phoneNumber']}');
      print('Product: ${orderData['productModel']} ${orderData['productCapacity']}');
      print('Price: ${orderData['evaluatedPrice']}');
      print('Address: ${orderData['address']}');
      print('DateTime: ${orderData['dateTime']}');
    } else {
      print('⚠️ No order data received in OrderPurchaseController');
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Initialize any additional data if needed
    _initializeOrderStatus();
  }

  @override
  void onClose() {
    print('🔄 OrderPurchaseController disposed');
    super.onClose();
  }

  // Initialize order status based on data
  void _initializeOrderStatus() {
    // You can set initial status based on order data
    if (orderData.isNotEmpty) {
      orderStatus.value = 'waiting_confirmation';
      // Initialize shipper data
      _initializeShipper();
    }
  }

  // Initialize shipper data
  void _initializeShipper() {
    // Create sample shipper data
    shipper.value = ShipperModel.createSample();

    // Start simulating shipper movement
    _startShipperMovementSimulation();
  }

  // Simulate shipper movement towards customer
  void _startShipperMovementSimulation() {
    if (shipper.value == null) return;

    // Update shipper position every 5 seconds to simulate movement
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (shipper.value == null) {
        timer.cancel();
        return;
      }

      final currentShipper = shipper.value!;
      final customerLat = getLocationFromAddress(customerAddress)?.latitude ?? 10.762622;
      final customerLng = getLocationFromAddress(customerAddress)?.longitude ?? 106.660172;

      // Calculate movement towards customer (small step each time)
      final latDiff = customerLat - currentShipper.latitude;
      final lngDiff = customerLng - currentShipper.longitude;

      // Move 10% closer each update
      final newLat = currentShipper.latitude + (latDiff * 0.1);
      final newLng = currentShipper.longitude + (lngDiff * 0.1);

      // Update shipper position
      shipper.value = currentShipper.copyWith(
        latitude: newLat,
        longitude: newLng,
      );

      // Stop when shipper is very close to customer
      final distance = _calculateDistance(newLat, newLng, customerLat, customerLng);
      if (distance < 0.001) { // Very close
        timer.cancel();
        // Update status to arrived
        shipper.value = currentShipper.copyWith(
          status: 'arrived',
          estimatedArrival: 'Đã đến',
        );
      }
    });
  }

  // Calculate distance between two points
  double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    return math.sqrt(math.pow(lat2 - lat1, 2) + math.pow(lng2 - lng1, 2));
  }

  // Get customer info
  String get customerName => orderData['contactName'] ?? 'Khách hàng';
  String get customerPhone => orderData['phoneNumber'] ?? 'N/A';
  String get customerAddress => orderData['address'] ?? 'N/A';
  String get pickupDateTime => orderData['dateTime'] ?? 'N/A';

  // Get product info
  String get productModel => orderData['productModel'] ?? 'iPhone';
  String get productCapacity => orderData['productCapacity'] ?? '';
  String get productVersion => orderData['productVersion'] ?? 'N/A';
  String get warranty => orderData['warranty'] ?? 'N/A';
  String get batteryStatus => orderData['batteryStatus'] ?? 'N/A';
  String get appearance => orderData['appearance'] ?? 'N/A';
  String get display => orderData['display'] ?? 'N/A';
  String get repair => orderData['repair'] ?? 'N/A';
  String get screenRepair => orderData['screenRepair'] ?? 'N/A';
  List<dynamic> get functionality => orderData['functionality'] ?? [];

  // Get price info
  int get evaluatedPrice => orderData['evaluatedPrice'] ?? 0;
  Map<String, dynamic>? get selectedVoucher => orderData['selectedVoucher'];

  // Get voucher discount amount
  int get voucherDiscount {
    if (selectedVoucher != null) {
      // Check percentage discount first
      final discountPercentage = selectedVoucher!['discountPercentage'];
      if (discountPercentage != null && discountPercentage > 0) {
        final percentage = discountPercentage is int ? discountPercentage.toDouble() : discountPercentage as double;
        return (evaluatedPrice * percentage / 100).round();
      }

      // Check fixed amount discount
      final discountAmount = selectedVoucher!['discountAmount'];
      if (discountAmount != null && discountAmount > 0) {
        return discountAmount as int;
      }
    }
    return 0;
  }

  // Calculate final price - use pre-calculated value if available
  int get finalPrice => orderData['finalPrice'] ?? (evaluatedPrice + voucherDiscount);

  // Order status methods
  void updateOrderStatus(String status) {
    orderStatus.value = status;
    print('📋 Order status updated to: $status');
  }

  String get orderStatusText {
    switch (orderStatus.value) {
      case 'waiting_confirmation':
        return 'Chờ xác nhận';
      case 'on_the_way':
        return 'Đang đến';
      case 'completed':
        return 'Hoàn thành';
      default:
        return 'Không xác định';
    }
  }

  // Check if status is active
  bool isStatusActive(String status) {
    final statusOrder = ['waiting_confirmation', 'on_the_way', 'completed'];
    final currentIndex = statusOrder.indexOf(orderStatus.value);
    final checkIndex = statusOrder.indexOf(status);
    return checkIndex <= currentIndex;
  }

  // Check if status is completed
  bool isStatusCompleted(String status) {
    final statusOrder = ['waiting_confirmation', 'on_the_way', 'completed'];
    final currentIndex = statusOrder.indexOf(orderStatus.value);
    final checkIndex = statusOrder.indexOf(status);
    return checkIndex < currentIndex;
  }

  // Confirm order
  Future<void> confirmOrder() async {
    try {
      isConfirming.value = true;

      // Here you would typically call an API to confirm the order
      print('🚀 Confirming order...');
      print('Order ID: ${DateTime.now().millisecondsSinceEpoch}');
      print('Customer: $customerName');
      print('Product: $productModel $productCapacity');
      print('Total: $finalPrice');

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Update status
      updateOrderStatus('on_the_way');

      // Show success message
      Get.snackbar(
        'Thành công',
        'Đơn hàng đã được xác nhận thành công!',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );

    } catch (e) {
      print('❌ Error confirming order: $e');
      Get.snackbar(
        'Lỗi',
        'Có lỗi xảy ra khi xác nhận đơn hàng',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isConfirming.value = false;
    }
  }

  // Cancel order
  void cancelOrder() {
    Get.dialog(
      AlertDialog(
        title: Text('Hủy đơn hàng'),
        content: Text('Bạn có chắc chắn muốn hủy đơn hàng này?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Không'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back(); // Go back to previous screen
              Get.snackbar(
                'Đã hủy',
                'Đơn hàng đã được hủy',
                snackPosition: SnackPosition.TOP,
              );
            },
            child: Text('Hủy đơn hàng'),
          ),
        ],
      ),
    );
  }

  // Contact actions
  void callCustomer() {
    print('📞 Calling customer: $customerPhone');
    // Here you would implement phone call functionality
    Get.snackbar(
      'Gọi điện',
      'Đang gọi đến $customerPhone',
      snackPosition: SnackPosition.TOP,
    );
  }

  void chatWithCustomer() {
    print('💬 Opening chat with: $customerName');
    // Here you would navigate to chat screen
    Get.snackbar(
      'Chat',
      'Mở chat với $customerName',
      snackPosition: SnackPosition.TOP,
    );
  }

  void showLocation() {
    print('📍 Showing location: $customerAddress');
    // Here you would open map with customer location
    Get.snackbar(
      'Vị trí',
      'Hiển thị vị trí: $customerAddress',
      snackPosition: SnackPosition.TOP,
    );
  }

  // Communication methods with shipper
  void chatWithShipper() async {
    if (shipper.value != null) {
      final phone = shipper.value!.phone;
      final url = 'sms:$phone';
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          Get.snackbar('Lỗi', 'Không thể mở ứng dụng tin nhắn');
        }
      } catch (e) {
        Get.snackbar('Lỗi', 'Không thể mở ứng dụng tin nhắn');
      }
    }
  }

  void callShipper() async {
    if (shipper.value != null) {
      final phone = shipper.value!.phone;
      final url = 'tel:$phone';
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          Get.snackbar('Lỗi', 'Không thể thực hiện cuộc gọi');
        }
      } catch (e) {
        Get.snackbar('Lỗi', 'Không thể thực hiện cuộc gọi');
      }
    }
  }

  // Format product specs for display
  String get productSpecs {
    final specs = <String>[];

    if (productCapacity.isNotEmpty) specs.add('Dung lượng: $productCapacity');
    if (productVersion != 'N/A') specs.add('Phiên bản: $productVersion');
    if (warranty != 'N/A') specs.add('Bảo hành: $warranty');
    if (batteryStatus != 'N/A') specs.add('Pin: $batteryStatus');
    if (appearance != 'N/A') specs.add('Vỏ ngoài: $appearance');

    return specs.join('\n');
  }

  // Get functionality as string
  String get functionalityText {
    if (functionality.isEmpty) return 'Không có thông tin';

    return functionality
        .map((item) => item['label']?.toString() ?? 'N/A')
        .join(', ');
  }

  // Google Maps methods
  void setMapController(GoogleMapController controller) {
    mapController = controller;
    print('📍 Google Maps controller set');
  }

  // Open location in Google Maps app
  Future<void> openInGoogleMaps() async {
    try {
      final address = customerAddress;
      if (address.isEmpty) {
        Get.snackbar(
          'Lỗi',
          'Không có địa chỉ để điều hướng',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // Create Google Maps URL
      final encodedAddress = Uri.encodeComponent(address);
      final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$encodedAddress';

      // Try to launch Google Maps app first, fallback to web
      final googleMapsAppUrl = 'comgooglemaps://?q=$encodedAddress';

      if (await canLaunchUrl(Uri.parse(googleMapsAppUrl))) {
        await launchUrl(Uri.parse(googleMapsAppUrl));
      } else if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(Uri.parse(googleMapsUrl), mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Lỗi',
          'Không thể mở Google Maps',
          snackPosition: SnackPosition.TOP,
        );
      }

      print('📍 Opening Google Maps for address: $address');

    } catch (e) {
      print('❌ Error opening Google Maps: $e');
      Get.snackbar(
        'Lỗi',
        'Có lỗi xảy ra khi mở Google Maps',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Get coordinates from address (basic implementation)
  LatLng? getLocationFromAddress(String address) {
    // For now, return some sample coordinates based on common areas
    // In production, you should use geocoding service

    final lowerAddress = address.toLowerCase();

    if (lowerAddress.contains('quận 1') || lowerAddress.contains('q1')) {
      return LatLng(10.762622, 106.660172);
    } else if (lowerAddress.contains('quận 3') || lowerAddress.contains('q3')) {
      return LatLng(10.786785, 106.695443);
    } else if (lowerAddress.contains('thủ đức')) {
      return LatLng(10.870000, 106.800000);
    } else if (lowerAddress.contains('bình thạnh')) {
      return LatLng(10.801755, 106.710000);
    } else if (lowerAddress.contains('tân bình')) {
      return LatLng(10.800000, 106.650000);
    } else if (lowerAddress.contains('quận 7') || lowerAddress.contains('q7')) {
      return LatLng(10.732776, 106.719674);
    } else if (lowerAddress.contains('quận 2') || lowerAddress.contains('q2')) {
      return LatLng(10.794232, 106.728020);
    }

    // Default to Ho Chi Minh City center
    return LatLng(10.762622, 106.660172);
  }

  // Move camera to specific location
  Future<void> moveToLocation(LatLng location) async {
    if (mapController != null) {
      await mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: location,
            zoom: 15.0,
          ),
        ),
      );
    }
  }
}