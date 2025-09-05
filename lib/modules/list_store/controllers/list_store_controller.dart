import 'dart:async';
import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../domain/store_model.dart';
import '../domain/mock_store_data.dart';
import '../services/phone_service.dart';

class ListStoreController extends GetxController {
  final stores = <StoreModel>[].obs;
  final filteredStores = <StoreModel>[].obs;
  final selectedLocation = LocaleKeys.filter_location_placeholder.trans().obs;
  final isLoading = false.obs;
  final currentLocation = Rxn<LatLng>();
  final nearestDistrict = ''.obs;
  
  Timer? _debounceTimer;
  bool _isCalculatingDistance = false;

  @override
  void onInit() {
    super.onInit();
    loadStores();
    _getCurrentLocationWithDebounce();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  void _getCurrentLocationWithDebounce() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: 300), () {
      getCurrentLocation();
    });
  }

  Future<void> getCurrentLocation() async {
    if (_isCalculatingDistance) return;
    
    try {
      _isCalculatingDistance = true;
      
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar('Lỗi', 'Quyền truy cập vị trí bị từ chối');
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: Duration(seconds: 10),
      );
      
      currentLocation.value = LatLng(position.latitude, position.longitude);
      
      await _calculateDistancesOptimized();
      _findNearestDistrict();
      
    } catch (e) {
      print('Error getting location: $e');
      Get.snackbar('Lỗi', 'Không thể lấy vị trí hiện tại');
    } finally {
      _isCalculatingDistance = false;
    }
  }

  Future<void> _calculateDistancesOptimized() async {
    if (currentLocation.value == null || stores.isEmpty) return;
    
    final currentLat = currentLocation.value!.latitude;
    final currentLng = currentLocation.value!.longitude;
    
    // Tính toán song song với batch processing
    final futures = <Future<void>>[];
    const batchSize = 10;
    
    for (int i = 0; i < stores.length; i += batchSize) {
      final end = (i + batchSize < stores.length) ? i + batchSize : stores.length;
      final batch = stores.sublist(i, end);
      
      futures.add(_processBatch(batch, currentLat, currentLng));
    }
    
    await Future.wait(futures);
    
    // Sắp xếp một lần sau khi tính toán xong
    stores.sort((a, b) {
      final distanceA = double.tryParse(a.distance) ?? double.infinity;
      final distanceB = double.tryParse(b.distance) ?? double.infinity;
      return distanceA.compareTo(distanceB);
    });
    
    filteredStores.assignAll(stores);
  }

  Future<void> _processBatch(List<StoreModel> batch, double currentLat, double currentLng) async {
    for (var store in batch) {
      final distance = Geolocator.distanceBetween(
        currentLat,
        currentLng,
        store.latitude,
        store.longitude,
      ) / 1000;
      
      store.distance = distance.toStringAsFixed(1);
    }
  }

  void _findNearestDistrict() {
    if (stores.isEmpty) return;
    
    final nearest = stores.first;
    nearestDistrict.value = nearest.district;
    selectedLocation.value = '${LocaleKeys.filter_nearest_prefix} ${nearest.district}';
  }

  void loadStores() {
    if (isLoading.value) return;
    
    isLoading.value = true;
    
    // Simulate async loading với microtask để không block UI
    Future.microtask(() {
      stores.assignAll(mockStores);
      filteredStores.assignAll(mockStores);
      isLoading.value = false;
    });
  }

  void filterByLocation(String location) {
    selectedLocation.value = location;
    
    // Debounce filter để tránh filter quá nhiều lần
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: 200), () {
      if (location == 'Vị trí' || location.isEmpty) {
        filteredStores.assignAll(stores);
      } else {
        final filtered = stores.where((store) => 
          store.district.toLowerCase().contains(location.toLowerCase())
        ).toList();
        filteredStores.assignAll(filtered);
      }
    });
  }

  Future<void> openDirections(StoreModel store) async {
    if (currentLocation.value == null) {
      Get.snackbar('Lỗi', 'Không thể xác định vị trí hiện tại');
      return;
    }
    
    try {
      final url = 'https://www.google.com/maps/dir/?api=1&origin=${currentLocation.value!.latitude},${currentLocation.value!.longitude}&destination=${store.latitude},${store.longitude}';
      
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar('Lỗi', 'Không thể mở Google Maps');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Lỗi khi mở chỉ đường: $e');
    }
  }

  Future<void> makePhoneCall({String? storeName}) async {
    await PhoneService.showCallConfirmDialog(
      phoneNumber: '0817433226',
      storeName: storeName ?? 'cửa hàng',
    );
  }

  Future<void> makeDirectCall() async {
    await PhoneService.makePhoneCall();
  }

  // Refresh location manually
  Future<void> refreshLocation() async {
    await getCurrentLocation();
  }
}
