import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../list_store/controllers/list_store_controller.dart';
import '../../list_store/domain/store_model.dart';
import '../domain/staff_model.dart';
import '../domain/mock_staff_data.dart';

class OrderPurchaseAtStoreController extends GetxController {
  // Order data received from arguments
  final orderData = <String, dynamic>{}.obs;

  // Order status
  final orderStatus =
      'waiting_confirmation'
          .obs; // waiting_confirmation, confirmed, ready_for_pickup, completed

  // Loading states
  final isLoading = false.obs;
  final isConfirming = false.obs;

  // Google Maps controller
  GoogleMapController? mapController;

  // Store information
  final currentStore = Rxn<StoreModel>();

  // Staff information
  final currentStaff = Rxn<StaffModel>();

  // Voucher selection
  final selectedVoucher = Rxn<Map<String, dynamic>>();

  // Getters for backward compatibility
  String? get staffName =>
      currentStaff.value?.name ?? orderData['staffName'] ?? 'Alice';

  String? get staffPhoneNumber =>
      currentStaff.value?.phoneNumber ??
      orderData['staffPhoneNumber'] ??
      '+84901234567';

  String? get staffCompletedOrders =>
      currentStaff.value?.completedOrders ??
      orderData['staffCompletedOrders'] ??
      '16493';

  String? get staffRating =>
      currentStaff.value?.rating ?? orderData['staffRating'] ?? '98';

  // Additional getters for order information
  String? get contactName => orderData['contactName'];

  String? get customerPhoneNumber => orderData['phoneNumber'];

  String? get orderId => orderData['orderId'];

  String? get evaluatedPriceString => orderData['evaluatedPrice'];

  String? get appointmentTime => orderData['appointmentTime'];

  @override
  void onInit() {
    super.onInit();
    _loadStoreInfo();
    _loadStaffInfo();
    // Get order data from arguments
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      orderData.value = arguments;
      print('📦 OrderPurchaseAtStoreController initialized with data:');
      print(
        'Customer: ${orderData['contactName']} - ${orderData['phoneNumber']}',
      );
      print(
        'Product: ${orderData['productModel']} ${orderData['productCapacity']}',
      );
      print('Price: ${orderData['evaluatedPrice']}');
      print('Store: ${orderData['storeName']}');
      print('DateTime: ${orderData['dateTime']}');

      // Load specific staff if provided
      final staffId = arguments['staffId'] as String?;
      if (staffId != null) {
        _loadSpecificStaff(staffId);
      }

      // Set default appointment time if not provided
      if (arguments['appointmentTime'] == null) {
        final now = DateTime.now();
        final appointmentTime = now.add(Duration(hours: 2));
        final endTime = appointmentTime.add(Duration(hours: 1));

        orderData['appointmentTime'] =
            '${appointmentTime.day.toString().padLeft(2, '0')}/${appointmentTime.month.toString().padLeft(2, '0')}/${appointmentTime.year} '
            '${appointmentTime.hour.toString().padLeft(2, '0')}:${appointmentTime.minute.toString().padLeft(2, '0')}-'
            '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
      }

      // Load voucher if provided
      final voucherData = arguments['selectedVoucher'];
      if (voucherData != null && voucherData is Map<String, dynamic>) {
        selectedVoucher.value = voucherData;
      }
    } else {
      print('⚠️ No order data received in OrderPurchaseAtStoreController');
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Initialize any additional data if needed
    _initializeOrderStatus();
  }

  void _initializeOrderStatus() {
    // Set initial status based on order data or business logic
    orderStatus.value = 'waiting_confirmation';
  }

  void _loadStoreInfo() {
    // Get store ID from order data
    final storeId = orderData['storeId'];
    print('🔍 Loading store info for ID: $storeId');

    if (storeId != null) {
      // Try to get ListStoreController
      try {
        if (Get.isRegistered<ListStoreController>()) {
          final storeController = Get.find<ListStoreController>();
          print('📋 Available stores: ${storeController.stores.length}');

          // Debug: Print all store IDs
          for (var store in storeController.stores) {
            print('🏪 Store ID: ${store.id}, Name: ${store.name}');
          }

          // Find store by ID
          final store = storeController.stores.firstWhereOrNull(
            (store) => store.id == storeId,
          );

          if (store != null) {
            currentStore.value = store;
            print('✅ Store loaded: ${store.name}');
            print('📍 Coordinates: ${store.latitude}, ${store.longitude}');
            print('🏢 Address: ${store.description}');
            print('🏪 District: ${store.district}');

            // Auto focus on store location if map is ready
            _focusOnStoreLocation();

            // Update marker position
            _updateMarkerPosition();
          } else {
            print('❌ Store not found with ID: $storeId');
            print(
              '📋 Available store IDs: ${storeController.stores.map((s) => s.id).join(', ')}',
            );
          }
        } else {
          print('⚠️ ListStoreController not registered');
        }
      } catch (e) {
        print('❌ Error loading store info: $e');
      }
    } else {
      print('⚠️ No store ID provided in order data');
      print('📦 Order data keys: ${orderData.keys.join(', ')}');
    }
  }

  void _focusOnStoreLocation() {
    // Auto focus on store location if map controller is available
    if (mapController != null && currentStore.value != null) {
      final store = currentStore.value!;

      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(store.latitude, store.longitude),
            zoom: 17.0, // Close zoom for store detail
            bearing: 0.0,
            tilt: 0.0,
          ),
        ),
      );

      print('📍 Map focused on store: ${store.name}');
    }
  }

  void _updateMarkerPosition() {
    // Trigger UI update by notifying observers
    // The Obx in StoreInfoWidget will automatically rebuild with new coordinates
    if (currentStore.value != null) {
      print('🔄 Updating marker position for: ${currentStore.value!.name}');
      print(
        '📍 New coordinates: ${currentStore.value!.latitude}, ${currentStore.value!.longitude}',
      );

      // Force focus on new store location
      _focusOnStoreLocation();
    }
  }

  // Public method to focus on store (can be called from widget)
  void focusOnStore() {
    _focusOnStoreLocation();
  }

  // Get customer info
  String get customerName => orderData['contactName'] ?? 'Khách hàng';

  String get customerPhone => orderData['phoneNumber'] ?? '';

  String get customerAddress => orderData['address'] ?? '';

  String get orderDateTime => orderData['dateTime'] ?? '';

  String get pickupDateTime =>
      orderData['pickupDateTime'] ?? orderData['dateTime'] ?? 'N/A';

  // Formatted pickup datetime
  String get formattedPickupDateTime {
    final dateTimeStr = pickupDateTime;
    if (dateTimeStr == 'N/A') return dateTimeStr;

    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} '
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeStr; // Return original if parsing fails
    }
  }

  String get pickupMethod =>
      orderData['pickupMethodName'] ?? 'Thu mua tại cửa hàng';

  // Get store info from currentStore (loaded from ListStoreController)
  String get storeName =>
      currentStore.value?.name ?? orderData['storeName'] ?? 'Cửa hàng FidoBox';

  String get storeAddress =>
      currentStore.value?.description ??
      orderData['storeAddress'] ??
      'Địa chỉ cửa hàng';

  String get storePhone =>
      '+84 123 456 789'; // Default phone, can be updated when StoreModel has phone
  double? get storeLatitude =>
      currentStore.value?.latitude ?? orderData['storeLatitude'];

  double? get storeLongitude =>
      currentStore.value?.longitude ?? orderData['storeLongitude'];

  // Get product info
  String get productModel => orderData['productModel'] ?? '';

  String get productCapacity => orderData['productCapacity'] ?? '';

  String get productVersion => orderData['productVersion'] ?? '';

  String get warranty => orderData['warranty'] ?? '';

  String get batteryStatus => orderData['batteryStatus'] ?? '';

  String get appearance => orderData['appearance'] ?? '';

  String get display => orderData['display'] ?? '';

  String get repair => orderData['repair'] ?? '';

  String get screenRepair => orderData['screenRepair'] ?? '';

  List<dynamic> get functionality => orderData['functionality'] ?? [];

  // Get price info
  int get evaluatedPrice {
    try {
      final price = orderData['evaluatedPrice'];
      if (price is int) return price;
      if (price is String) {
        // Try to parse string price (remove commas and currency)
        final cleanPrice = price.replaceAll(RegExp(r'[^\d]'), '');
        return int.tryParse(cleanPrice) ?? 0;
      }
      return 0;
    } catch (e) {
      print('Error parsing evaluatedPrice: $e');
      return 0;
    }
  }

  // selectedVoucher is already defined as observable above

  // Get voucher discount amount
  int get voucherDiscount {
    try {
      final voucher = selectedVoucher.value;
      if (voucher != null) {
        // Check percentage discount first
        final discountPercentage = voucher['discountPercentage'];
        if (discountPercentage != null && discountPercentage > 0) {
          final percentage =
              discountPercentage is int
                  ? discountPercentage.toDouble()
                  : discountPercentage as double;
          final priceValue = evaluatedPrice;
          return (priceValue * percentage / 100).round();
        }

        // Check fixed amount discount
        final discountAmount = voucher['discountAmount'];
        if (discountAmount != null && discountAmount > 0) {
          return discountAmount as int;
        }
      }
    } catch (e) {
      print('Error calculating voucher discount: $e');
    }
    return 0;
  }

  // Calculate final price - use pre-calculated value if available
  int get finalPrice {
    try {
      final preCalculated = orderData['finalPrice'];
      if (preCalculated is int) return preCalculated;
      return evaluatedPrice + voucherDiscount;
    } catch (e) {
      print('Error calculating final price: $e');
      return evaluatedPrice;
    }
  }

  // Order status methods
  void updateOrderStatus(String status) {
    orderStatus.value = status;
    print('📋 Order status updated to: $status');
  }

  String get orderStatusText {
    switch (orderStatus.value) {
      case 'waiting_confirmation':
        return 'Chờ xác nhận';
      case 'confirmed':
        return 'Đã xác nhận';
      case 'preparing':
        return 'Đang chuẩn bị';
      case 'ready_for_pickup':
        return 'Sẵn sàng nhận hàng';
      case 'completed':
        return 'Hoàn thành';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }

  Color get orderStatusColor {
    switch (orderStatus.value) {
      case 'waiting_confirmation':
        return Colors.orange;
      case 'confirmed':
      case 'preparing':
        return Colors.blue;
      case 'ready_for_pickup':
        return Colors.green;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Confirm order
  Future<void> confirmOrder() async {
    try {
      isConfirming.value = true;

      // Here you would typically call an API to confirm the order
      print('🚀 Confirming store pickup order...');
      print('Order ID: ${DateTime.now().millisecondsSinceEpoch}');
      print('Customer: $customerName');
      print('Product: $productModel $productCapacity');
      print('Total: $finalPrice');
      print('Store pickup method');

      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Update order status
      updateOrderStatus('confirmed');

      // Show success message
      Get.snackbar(
        'Thành công',
        'Đơn hàng đã được xác nhận. Bạn có thể đến cửa hàng để nhận hàng.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withValues(alpha: 0.1),
        colorText: Colors.green,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      print('❌ Error confirming order: $e');
      Get.snackbar(
        'Lỗi',
        'Có lỗi xảy ra khi xác nhận đơn hàng. Vui lòng thử lại.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withValues(alpha: 0.1),
        colorText: Colors.red,
      );
    } finally {
      isConfirming.value = false;
    }
  }

  // Call store
  Future<void> callStore() async {
    final storePhone = orderData['storePhone'] ?? '+84 123 456 789';
    final uri = Uri.parse('tel:$storePhone');

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $uri';
      }
    } catch (e) {
      print('❌ Error calling store: $e');
      Get.snackbar(
        'Lỗi',
        'Không thể thực hiện cuộc gọi',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Navigate to store using real coordinates
  Future<void> navigateToStore() async {
    final store = currentStore.value;

    if (store != null) {
      final lat = store.latitude;
      final lng = store.longitude;
      final storeName = store.name;

      // Use search URL with coordinates as query parameter
      final uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      );

      print('🔗 Google Maps Search URL: $uri');
      print('📍 Using coordinates as search query: $lat,$lng');

      try {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);

          Get.snackbar(
            'Đang chỉ đường',
            'Đến ${store.district} • ${store.distance} km',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.AS01,
            colorText: AppColors.white,
            duration: Duration(seconds: 2),
            icon: Icon(Icons.navigation, color: AppColors.white),
          );
        } else {
          throw Exception('Could not launch $uri');
        }
      } catch (e) {
        print('❌ Error: $e');
        Get.snackbar(
          'Lỗi',
          'Không thể mở Google Maps',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.AE01,
          colorText: AppColors.white,
        );
      }
    } else {
      // Fallback: Try to get coordinates from orderData
      print('⚠️ No store model available, checking orderData for coordinates');

      final lat = orderData['storeLatitude'];
      final lng = orderData['storeLongitude'];

      if (lat != null && lng != null) {
        // Use coordinates from orderData - ONLY COORDINATES, NO NAME
        final uri = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
        );

        print('🔗 Google Maps Search URL (from orderData): $uri');
        print('📍 Using coordinates from orderData: $lat,$lng');

        try {
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
            print('✅ Successfully launched Google Maps with orderData coordinates');
          } else {
            throw Exception('Could not launch $uri');
          }
        } catch (e) {
          print('❌ Error: $e');
          Get.snackbar(
            'Lỗi',
            'Không thể mở Google Maps',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.AE01,
            colorText: AppColors.white,
          );
        }
      } else {
        // No coordinates available at all
        print('❌ No coordinates available in store model or orderData');
        Get.snackbar(
          'Lỗi',
          'Không tìm thấy tọa độ cửa hàng để chỉ đường',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.AE01,
          colorText: AppColors.white,
        );
      }
    }
  }

  // Staff management methods
  void _loadStaffInfo() {
    try {
      // Load default staff or random staff
      final staff = MockStaffData.getRandomStaff();
      currentStaff.value = staff;
      print('✅ Staff loaded: ${staff.name} (${staff.rating}% rating)');
    } catch (e) {
      print('❌ Error loading staff: $e');
      // Keep default values from getters
    }
  }

  void _loadSpecificStaff(String staffId) {
    try {
      final staff = MockStaffData.getStaffById(staffId);
      if (staff != null) {
        currentStaff.value = staff;
        print('✅ Specific staff loaded: ${staff.name}');
      } else {
        print('⚠️ Staff not found with ID: $staffId');
      }
    } catch (e) {
      print('❌ Error loading specific staff: $e');
    }
  }

  void assignStaff(StaffModel staff) {
    currentStaff.value = staff;
    // Update order data for backward compatibility
    orderData.addAll({
      'staffId': staff.id,
      'staffName': staff.name,
      'staffPhoneNumber': staff.phoneNumber,
      'staffCompletedOrders': staff.completedOrders,
      'staffRating': staff.rating,
    });
  }

  void callStaff() {
    final staff = currentStaff.value;
    if (staff != null && staff.phoneNumber.isNotEmpty) {
      _launchPhone(staff.phoneNumber);
    } else {
      Get.snackbar(
        'Thông báo',
        'Không thể lấy số điện thoại nhân viên',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  void messageStaff() {
    final staff = currentStaff.value;
    if (staff != null) {
      // Navigate to chat or show message
      Get.snackbar(
        'Thông báo',
        'Đang mở cuộc trò chuyện với ${staff.name}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // TODO: Navigate to chat screen
      // Get.toNamed('/chat', arguments: {'staffId': staff.id});
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    try {
      final uri = Uri.parse('tel:$phoneNumber');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      print('❌ Error launching phone: $e');
      Get.snackbar(
        'Lỗi',
        'Không thể mở ứng dụng điện thoại',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Voucher management methods
  void selectVoucher(Map<String, dynamic> voucher) {
    selectedVoucher.value = voucher;
    orderData['selectedVoucher'] = voucher;
    print('🎫 Voucher selected: ${voucher['name'] ?? 'Unknown'}');

    Get.snackbar(
      'Áp dụng voucher',
      'Đã áp dụng voucher thành công',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void removeVoucher() {
    selectedVoucher.value = null;
    orderData.remove('selectedVoucher');
    print('🎫 Voucher removed');

    Get.snackbar(
      'Hủy voucher',
      'Đã hủy voucher',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  // Contact actions (similar to OrderPurchaseAtHomeController)
  void callCustomer() {
    final phone = customerPhoneNumber ?? '';
    if (phone.isNotEmpty) {
      _launchPhone(phone);
    } else {
      Get.snackbar(
        'Lỗi',
        'Không tìm thấy số điện thoại khách hàng',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void chatWithCustomer() {
    final name = contactName ?? 'Khách hàng';
    print('💬 Opening chat with: $name');
    Get.snackbar(
      'Chat',
      'Mở chat với $name',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
    // TODO: Navigate to chat screen
    // Get.toNamed('/chat', arguments: {'customerId': orderId});
  }

  void showStoreLocation() {
    final storeName = currentStore.value?.name ?? 'cửa hàng';
    print('📍 Showing store location: $storeName');
    Get.snackbar(
      'Vị trí cửa hàng',
      'Hiển thị vị trí: $storeName',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    // TODO: Open map with store location
  }

  // Cancel order (similar to OrderPurchaseAtHomeController)
  void cancelOrder() {
    Get.dialog(
      AlertDialog(
        title: Text('Hủy đơn hàng'),
        content: Text('Bạn có chắc chắn muốn hủy đơn hàng này?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Không')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back(); // Go back to previous screen
              Get.snackbar(
                'Đã hủy',
                'Đơn hàng đã được hủy',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.orange,
                colorText: Colors.white,
              );
            },
            child: Text('Hủy đơn hàng'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    if (mapController != null) {
      mapController?.dispose();
    }
    print('🔄 OrderPurchaseAtStoreController disposed');
    super.onClose();
  }
}
