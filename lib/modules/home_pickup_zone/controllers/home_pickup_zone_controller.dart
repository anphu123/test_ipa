import 'dart:async';

import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/pickup_zone_model.dart';
import '../domain/pickup_zone_repository.dart';
import '../services/booking_address_service.dart';
import '../services/notification_service.dart';
import '../widgets/booking_address_list_widget.dart';
import '../widgets/zone_details_widget.dart';
import '../widgets/pickup_booking_form.dart';

/// 🗺️ Controller quản lý màn hình bản đồ khu vực thu mua tại nhà
///
/// ## Chức năng chính:
/// - Hiển thị các khu vực thu mua trên bản đồ
/// - Xác định vị trí người dùng và kiểm tra có trong zone không
/// - Xử lý đặt lịch thu mua tại nhà
/// - Quản lý tương tác với Google Maps
///
/// ## Kiến trúc:
/// - **Business Logic Only**: Không chứa UI code
/// - **Service Integration**: Sử dụng BookingAddressService cho data operations
/// - **Clean Separation**: UI logic được tách ra thành widgets riêng
///
/// ## Maintenance Notes:
/// - Luôn gọi `_loadBookingList()` sau khi thay đổi data
/// - Sử dụng NotificationService cho tất cả UI notifications
/// - Dispose resources trong onClose() để tránh memory leaks
///
/// @see BookingAddressService - Data operations
/// @see NotificationService - UI notifications
/// @see BookingAddressListWidget - Address list UI
/// @version 2.0.0 - Clean Architecture Refactor
class HomePickupZoneController extends GetxController {
  final PickupZoneRepository _repository = PickupZoneRepository();
  final BookingAddressService _addressService = BookingAddressService();
  GoogleMapController? mapController; // 🗺️ Controller của Google Maps

  // 📊 Observable state - Các biến trạng thái reactive
  final selectedLocation = 'Địa điểm'.obs; // 📍 Địa điểm đang chọn
  final centerLocation =
      LatLng(10.7769, 106.7009).obs; // 🎯 Tọa độ trung tâm bản đồ (HCM)
  final zoneDescription = 'Quy tắc'.obs; // 📝 Mô tả zone hiện tại
  final isLoading = false.obs; // ⏳ Trạng thái loading
  final searchQuery = ''.obs; // 🔍 Từ khóa tìm kiếm
  final defaultAddressId = ''.obs; // 🏠 ID của địa chỉ mặc định
  final currentLocation = Rxn<LatLng>(); // 📱 Vị trí hiện tại của user
  final searchSuggestions = <Map<String, dynamic>>[].obs; // 📝 Gợi ý tìm kiếm
  Timer? _searchDebounceTimer;

  // 📚 Data sources - Nguồn dữ liệu
  final locations = <LocationModel>[].obs; // 📍 Danh sách các địa điểm
  final pickupZones = <PickupZoneModel>[].obs; // 🏘️ Danh sách khu vực thu mua
  final serviceZones = <Polygon>{}.obs; // 🔷 Các vùng polygon trên bản đồ
  final markers = <Marker>{}.obs; // 📌 Các marker trên bản đồ

  // ✅ Thay đổi từ single object thành list
  final savedBookingList = <Map<String, dynamic>>[].obs;

  // ✅ Selection mode variables
  final isSelectionMode = false.obs;
  final selectedBookingIds = <String>{}.obs;

  // ✅ Selection mode methods
  void toggleSelectionMode() {
    isSelectionMode.value = !isSelectionMode.value;
    if (!isSelectionMode.value) {
      selectedBookingIds.clear();
    }
  }

  void toggleBookingSelection(String id) {
    if (selectedBookingIds.contains(id)) {
      selectedBookingIds.remove(id);
    } else {
      selectedBookingIds.add(id);
    }
  }

  void _toggleBookingSelection(String id) => toggleBookingSelection(id);

  bool isBookingSelected(String id) => selectedBookingIds.contains(id);

  void selectAllBookings() {
    selectedBookingIds.assignAll(
      savedBookingList.map((item) => item['id'] as String),
    );
  }

  // void deleteSelectedBookings() {
  //   final selectedCount = selectedBookingIds.length;
  //   savedBookingList.removeWhere((item) => selectedBookingIds.contains(item['id']));
  //   selectedBookingIds.clear();
  //   isSelectionMode.value = false;
  //   _saveBookingList();
  //
  //   Get.snackbar(
  //     'Đã xóa',
  //     'Đã xóa $selectedCount địa chỉ',
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: AppColors.success,
  //     colorText: Colors.white,
  //     duration: Duration(seconds: 2),
  //   );
  // }

  @override
  void onInit() {
    super.onInit();
    _loadBookingList(); // 🔄 Load list từ storage
    _createMockDataIfEmpty(); // 🎭 Tạo mock data nếu rỗng
    _loadData();
    getCurrentLocation();
  }

  // ✅ Load booking list từ service
  void _loadBookingList() {
    final data = _addressService.getBookingList();
    savedBookingList.assignAll(data);

    // Cập nhật default address ID để trigger UI update
    final defaultAddress = _addressService.getDefaultAddress();
    defaultAddressId.value = defaultAddress?['id'] ?? '';
  }

  // ✅ Public method để reload booking list
  void reloadBookingList() {
    _loadBookingList();
  }

  // 🎭 Tạo mock data nếu danh sách rỗng
  void _createMockDataIfEmpty() {
    if (savedBookingList.isEmpty) {
      final mockAddresses = [
        {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'contactName': 'xiaoyu',
          'phoneNumber': '0123456789',
          'fullAddress': '21 Tân Cảng, Phường 25, Bình Thạnh, Hồ Chí Minh',
          'street': '21 Tân Cảng',
          'ward': 'Phường 25',
          'district': 'Bình Thạnh',
          'city': 'Hồ Chí Minh',
          'note': '',
          'latitude': 10.8014,
          'longitude': 106.7109,
          'distance': '3.5',
          'createdAt': DateTime.now().millisecondsSinceEpoch,
          'isDefault': false,
        },
      ];

      // Lưu mock data vào storage
      for (final address in mockAddresses) {
        _addressService.addBookingData(address);
      }

      // Reload list để hiển thị mock data
      _loadBookingList();

      print('🎭 Created ${mockAddresses.length} mock addresses');
    }
  }

  // ✅ Method thêm booking data vào list
  void addBookingData(Map<String, dynamic> data) {
    _addressService.addBookingData(data);
    _loadBookingList(); // Refresh list
  }

  // ✅ Method xóa một địa chỉ
  void removeBookingData(String id) {
    // Lấy thông tin địa chỉ trước khi xóa để hiển thị thông báo
    final addressToDelete = _addressService.getBookingById(id);
    final wasDefault = _addressService.isDefaultAddress(id);
    final removed = _addressService.removeBookingData(id);

    if (removed) {
      // Cập nhật list ngay lập tức
      _loadBookingList();

      // Hiển thị thông báo phù hợp
      if (wasDefault) {
        NotificationService.showDefaultAddressDeleted();
      } else {
        final addressName = addressToDelete?['fullAddress'] ?? 'Địa chỉ';
        NotificationService.showAddressDeleted(addressName);
      }
    } else {
      NotificationService.showError('Lỗi', 'Không thể xóa địa chỉ');
    }
  }

  // ✅ Method cập nhật địa chỉ với validation và feedback tốt hơn
  void updateBookingData(String id, Map<String, dynamic> updatedData) {
    try {
      // Validation cơ bản
      if (id.isEmpty) {
        NotificationService.showError('Lỗi', 'ID địa chỉ không hợp lệ');
        return;
      }

      if (updatedData['contactName']?.toString().trim().isEmpty == true ||
          updatedData['phoneNumber']?.toString().trim().isEmpty == true ||
          updatedData['fullAddress']?.toString().trim().isEmpty == true) {
        NotificationService.showError('Lỗi', 'Vui lòng điền đầy đủ thông tin');
        return;
      }

      // Hiển thị loading
      isLoading.value = true;

      // Cập nhật trong service
      final success = _addressService.updateBookingData(id, updatedData);

      if (success) {
        // Reload danh sách để cập nhật UI
        _loadBookingList();

        // Hiển thị thông báo thành công
        NotificationService.showSuccess(
          'Thành công',
          'Địa chỉ "${updatedData['contactName']}" đã được cập nhật',
        );

        print('Address updated successfully: $id');
      } else {
        NotificationService.showError('Lỗi', 'Không thể cập nhật địa chỉ');
      }
    } catch (e) {
      print('Error updating booking data: $e');
      NotificationService.showError(
        'Lỗi',
        'Có lỗi xảy ra khi cập nhật địa chỉ: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ Method xóa tất cả
  void clearAllBookingData() {
    // Hiển thị dialog xác nhận trước khi xóa tất cả
    NotificationService.showDeleteConfirmDialog(
      title: 'Xác nhận xóa tất cả',
      message:
          'Bạn có chắc muốn xóa tất cả ${savedBookingList.length} địa chỉ đã lưu?',
    ).then((confirmed) {
      if (confirmed) {
        _addressService.clearAllBookingData();
        savedBookingList.clear();
        selectedBookingIds.clear();
        isSelectionMode.value = false;
        NotificationService.showAllAddressesCleared();
      }
    });
  }

  /// 📥 Tải dữ liệu từ repository (locations và pickup zones)
  Future<void> _loadData() async {
    isLoading.value = true;
    try {
      // 🌐 Gọi API để lấy danh sách địa điểm và khu vực
      final locationList = await _repository.getLocations();
      final zoneList = await _repository.getPickupZones();

      // 📋 Cập nhật dữ liệu vào observable lists
      locations.assignAll(locationList);
      pickupZones.assignAll(zoneList);

      _displayAllZones(); // 🗺️ Hiển thị tất cả zones trên bản đồ
    } catch (e) {
      _showError('Không thể tải dữ liệu: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// 🗺️ Hiển thị tất cả các khu vực thu mua trên bản đồ
  void _displayAllZones() {
    final allPolygons = <Polygon>{};
    final allMarkers = <Marker>{};

    // 🔷 Tạo polygon cho mỗi pickup zone
    for (final zone in pickupZones) {
      allPolygons.add(
        Polygon(
          polygonId: PolygonId(zone.id),
          points: zone.boundaries,
          // 📍 Các điểm biên giới
          strokeColor: AppColors.primary01,
          // 🎨 Màu viền
          strokeWidth: 2,
          // 📏 Độ dày viền
          fillColor: AppColors.primary01.withOpacity(
            0.2,
          ), // 🎨 Màu nền trong suốt
        ),
      );
    }

    // 📌 Chỉ hiển thị marker của zone gần nhất với user
    final nearestZone = _findNearestZone();
    if (nearestZone != null) {
      allMarkers.add(
        Marker(
          markerId: MarkerId('${nearestZone.id}_center'),
          position: nearestZone.center, // 📍 Vị trí trung tâm zone
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: nearestZone.name,
            snippet: '${nearestZone.operatingHours}', // ⏰ Giờ hoạt động
          ),
        ),
      );
    }

    // 🔄 Cập nhật UI
    serviceZones.value = allPolygons;
    markers.value = allMarkers;
  }

  /// 📍 Thay đổi địa điểm được chọn và cập nhật bản đồ
  void changeLocation(String name) {
    selectedLocation.value = name;

    // 🌍 Nếu chọn "Địa điểm" thì hiển thị tất cả zones
    if (name == 'Địa điểm') {
      _displayAllZones();
      return;
    }

    // 🏘️ Tìm pickup zone theo tên
    final zone = FirstWhereExt(
      pickupZones,
    ).firstWhereOrNull((z) => z.name == name);
    if (zone != null) {
      _setZoneOnMap(zone);
      return;
    }

    // 📍 Tìm location theo tên
    final location = FirstWhereExt(
      locations,
    ).firstWhereOrNull((l) => l.name == name);
    if (location != null) {
      _setLocationOnMap(location);
    }
  }

  /// 🏘️ Hiển thị một pickup zone cụ thể trên bản đồ
  void _setZoneOnMap(PickupZoneModel zone) {
    centerLocation.value = zone.center;
    zoneDescription.value = zone.description;

    // 🔷 Tạo polygon cho zone này
    serviceZones.value = {
      Polygon(
        polygonId: PolygonId(zone.id),
        points: zone.boundaries,
        strokeColor: AppColors.primary01,
        strokeWidth: 2,
        fillColor: AppColors.primary01.withOpacity(0.2),
      ),
    };

    // 📌 Tạo marker cho zone
    markers.value = {
      Marker(
        markerId: MarkerId('${zone.id}_center'),
        position: zone.center,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: 'Khu vực thu mua tại nhà',
          snippet: '${zone.name} - ${zone.operatingHours}',
        ),
      ),
    };

    _moveCamera(zone.center); // 📷 Di chuyển camera đến zone
  }

  /// 📍 Hiển thị một location cụ thể trên bản đồ
  void _setLocationOnMap(LocationModel location) {
    centerLocation.value = location.coordinates;
    zoneDescription.value =
        location.hasPickupService
            ? 'Có hỗ trợ thu mua tại nhà'
            : 'Chưa hỗ trợ thu mua tại nhà';

    // 🎨 Màu sắc tùy theo có hỗ trợ pickup hay không
    final color =
        location.hasPickupService ? AppColors.primary01 : AppColors.neutral04;
    final boundaries = _generateSquareAround(location.coordinates);

    // 🔷 Tạo polygon hình vuông xung quanh location
    serviceZones.value = {
      Polygon(
        polygonId: PolygonId(location.id),
        points: boundaries,
        strokeColor: color,
        strokeWidth: 2,
        fillColor: color.withOpacity(0.2),
      ),
    };

    // 📌 Tạo marker với màu tương ứng
    final hue =
        location.hasPickupService
            ? BitmapDescriptor.hueRed
            : BitmapDescriptor.hueOrange;

    markers.value = {
      Marker(
        markerId: MarkerId('${location.id}_center'),
        position: location.coordinates,
        icon: BitmapDescriptor.defaultMarkerWithHue(hue),
        infoWindow: InfoWindow(
          title: location.name,
          snippet: zoneDescription.value,
        ),
      ),
    };

    _moveCamera(location.coordinates); // 📷 Di chuyển camera đến location
  }

  /// 🔲 Tạo hình vuông xung quanh một điểm (dùng cho location)
  List<LatLng> _generateSquareAround(LatLng center) {
    const offset = 0.015; // 📏 Kích thước hình vuông
    return [
      LatLng(center.latitude + offset, center.longitude - offset),
      // Góc trên trái
      LatLng(center.latitude + offset, center.longitude + offset),
      // Góc trên phải
      LatLng(center.latitude - offset, center.longitude + offset),
      // Góc dưới phải
      LatLng(center.latitude - offset, center.longitude - offset),
      // Góc dưới trái
    ];
  }

  /// 📷 Di chuyển camera bản đồ đến vị trí chỉ định
  void _moveCamera(LatLng position) {
    mapController?.animateCamera(CameraUpdate.newLatLng(position));
  }

  /// 📅 Xử lý đặt lịch thu mua tại nhà
  Future<void> bookHomePickup() async {
    final zone = getCurrentPickupZone();
    showBookingDialog(zone);
  }

  /// 💬 Hiển thị dialog đặt lịch - UI method
  void showBookingDialog([PickupZoneModel? zone]) {
    try {
      // Debug: kiểm tra trạng thái trước khi hiển thị
      print(
        'showBookingDialog called - savedBookingList.length: ${savedBookingList.length}',
      );

      // Đảm bảo data được load
      _loadBookingList();

      NotificationService.showBottomSheet(
        Obx(() {
          // Đảm bảo widget rebuild khi defaultAddressId thay đổi
          final _ = defaultAddressId.value;

          // Kiểm tra nếu list rỗng
          if (savedBookingList.isEmpty) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 48,
                    color: AppColors.neutral03,
                  ),
                  SizedBox(height: 16),
                  Text('Chưa có địa chỉ nào', style: AppTypography.s16.medium),
                  SizedBox(height: 8),
                  Text(
                    'Hãy thêm địa chỉ đầu tiên của bạn',
                    style: AppTypography.s14.regular.copyWith(
                      color: AppColors.neutral02,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _showDetailForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary01,
                    ),
                    child: Text(
                      LocaleKeys.add_new_address.trans(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          return BookingAddressListWidget(
            bookingList: savedBookingList,
            onAddressSelected: _useSelectedAddress,
            onAddressDeleted: removeBookingData,
            onSetDefault: setDefaultAddress,
            onClearAll: clearAllBookingData,
            onAddNew: _showDetailForm,
            onUseCurrentLocation: _useCurrentLocation,
            onShowForm: showAddressForm,
            isSelectionMode: isSelectionMode.value,
            selectedIds: selectedBookingIds,
            onToggleSelectionMode: toggleSelectionMode,
            onToggleSelection: _toggleBookingSelection,
            onDeleteSelected: deleteSelectedBookings,
            onAddressUpdated: updateBookingData,
          );
        }),
      );
    } catch (e) {
      print('Error in showBookingDialog: $e');
      NotificationService.showError(
        'Lỗi',
        'Không thể hiển thị danh sách địa chỉ: $e',
      );
    }
  }

  // This method is now replaced by showBookingDialog() which uses the widget

  // UI methods moved to widgets - this method is no longer needed

  // ✅ Method sử dụng địa chỉ đã chọn
  void _useSelectedAddress(Map<String, dynamic> booking) {
    // Di chuyển camera đến địa chỉ
    final coords = LatLng(booking['latitude'], booking['longitude']);
    _moveCamera(coords);

    // Thêm marker
    addBookingMarker(coords, booking['fullAddress']);

    // Get.snackbar(
    //   'Đã chọn địa chỉ',
    //   booking['fullAddress'],
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: AppColors.primary01,
    //   colorText: Colors.white,
    //   duration: Duration(seconds: 2),
    // );
  }

  /// 📋 Hiển thị form chi tiết để nhập địa chỉ
  void _showDetailForm() {
    Get.bottomSheet(
      PickupBookingForm(
        onSubmit: () {
          // 🎯 Xử lý khi submit form
          print('Form submitted successfully');
        },
      ),
      isScrollControlled: true,
    );
  }

  /// 🏘️ Lấy pickup zone hiện tại mà user đang ở trong đó
  PickupZoneModel? getCurrentPickupZone() {
    if (currentLocation.value == null) return null;

    // 🔍 Kiểm tra từng zone xem user có ở trong không
    for (final zone in pickupZones) {
      if (_isPointInPolygon(currentLocation.value!, zone.boundaries)) {
        return zone;
      }
    }
    return null;
  }

  /// ✅ Kiểm tra user có ở trong bất kỳ zone nào không
  bool isUserInAnyZone() {
    if (currentLocation.value == null) return false;

    for (final zone in pickupZones) {
      if (_isPointInPolygon(currentLocation.value!, zone.boundaries)) {
        return true;
      }
    }
    return false;
  }

  /// 📅 Kiểm tra có thể đặt lịch thu mua tại nhà không
  bool canBookHomePickup() {
    return isUserInAnyZone();
  }

  /// 📋 Lấy danh sách tên các location
  List<String> get locationNames => locations.map((e) => e.name).toList();

  /// ❌ Hiển thị thông báo lỗi
  void _showError(String message) {
    Get.snackbar(
      'Thông báo',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }

  /// 📱 Lấy vị trí hiện tại của user
  Future<void> getCurrentLocation() async {
    try {
      // 🔐 Kiểm tra và yêu cầu quyền truy cập vị trí
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // ✅ Nếu có quyền, lấy vị trí hiện tại
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high, // 🎯 Độ chính xác cao
        );

        // 📍 Cập nhật vị trí hiện tại
        currentLocation.value = LatLng(position.latitude, position.longitude);
        centerLocation.value = currentLocation.value!;

        // 🏘️ Tự động cập nhật zone hiện tại nếu user đang ở trong zone
        final currentZone = getCurrentPickupZone();
        if (currentZone != null) {
          selectedLocation.value = currentZone.name;
          zoneDescription.value = currentZone.description;
          _setZoneOnMap(currentZone);
        } else {
          // 🌍 Nếu không ở trong zone nào, hiển thị tất cả zones
          selectedLocation.value = 'Địa điểm';
          zoneDescription.value = 'Quy tắc';
          // _displayAllZones(); // Commented out để tránh reset view
        }

        // 🔍 Debug log
        print('Current location: ${currentLocation.value}');
        print('Current zone: ${currentZone?.name}');
        print('Can book: ${canBookHomePickup()}');

        _moveCamera(
          currentLocation.value!,
        ); // 📷 Di chuyển camera đến vị trí hiện tại
      }
    } catch (e) {
      _showError('Không thể lấy vị trí hiện tại: $e');
    }
  }

  /// ℹ️ Hiển thị thông tin chi tiết của một zone
  void showZoneInfo(PickupZoneModel zone) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Khu vực thu mua tại nhà', style: AppTypography.s16.bold),
            SizedBox(height: 8),
            Text(zone.name, style: AppTypography.s14.medium),
            SizedBox(height: 16),
            Row(
              children: [
                // 📋 Button xem quy tắc
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text('Quy tắc'),
                  ),
                ),
                SizedBox(width: 12),
                // 📅 Button đặt lịch
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => bookHomePickup(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary01,
                    ),
                    child: Text(
                      'Đặt lịch',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    mapController?.dispose(); // 🧹 Cleanup map controller
    super.onClose();
  }

  /// 🔍 Tìm zone gần nhất với vị trí hiện tại
  PickupZoneModel? _findNearestZone() {
    if (currentLocation.value == null || pickupZones.isEmpty) {
      return pickupZones.isNotEmpty ? pickupZones.first : null;
    }

    PickupZoneModel? nearestZone;
    double minDistance = double.infinity;

    // 📏 Tính khoảng cách đến từng zone
    for (final zone in pickupZones) {
      final distance = Geolocator.distanceBetween(
        currentLocation.value!.latitude,
        currentLocation.value!.longitude,
        zone.center.latitude,
        zone.center.longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearestZone = zone;
      }
    }

    return nearestZone;
  }

  // 🔍 Address validation methods - Các phương thức validate địa chỉ

  /// ✅ Kiểm tra một địa chỉ có nằm trong pickup zone không
  bool isAddressInPickupZone(LatLng address) {
    for (final zone in pickupZones) {
      if (_isPointInPolygon(address, zone.boundaries)) {
        return true;
      }
    }
    return false;
  }

  /// 🏘️ Lấy pickup zone chứa địa chỉ cụ thể
  PickupZoneModel? getPickupZoneForAddress(LatLng address) {
    return FirstWhereExt(
      pickupZones,
    ).firstWhereOrNull((zone) => _isPointInPolygon(address, zone.boundaries));
  }

  /// 🔍 Tìm pickup zone gần nhất với một địa chỉ
  PickupZoneModel? findNearestPickupZone(LatLng address) {
    if (pickupZones.isEmpty) return null;

    PickupZoneModel? nearest;
    double minDistance = double.infinity;

    for (final zone in pickupZones) {
      final distance = calculateDistanceToZone(address, zone);
      if (distance < minDistance) {
        minDistance = distance;
        nearest = zone;
      }
    }

    return nearest;
  }

  /// 📏 Tính khoảng cách từ địa chỉ đến zone (km)
  double calculateDistanceToZone(LatLng point, PickupZoneModel zone) {
    // Calculate distance to zone center or nearest boundary point
    // For simplicity, calculate to first boundary point
    if (zone.boundaries.isEmpty) return double.infinity;

    final zoneBoundary = zone.boundaries.first;
    return Geolocator.distanceBetween(
          point.latitude,
          point.longitude,
          zoneBoundary.latitude,
          zoneBoundary.longitude,
        ) /
        1000; // Convert to km
  }

  /// 📍 Thêm marker cho địa chỉ đã đặt lịch
  void addBookingMarker(LatLng coordinates, String address) {
    final newMarker = Marker(
      markerId: MarkerId('booking_${DateTime.now().millisecondsSinceEpoch}'),
      position: coordinates,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title: 'Địa chỉ đặt lịch', snippet: address),
    );

    // Thêm marker mới vào danh sách
    final updatedMarkers = Set<Marker>.from(markers.value);
    updatedMarkers.add(newMarker);
    markers.value = updatedMarkers;

    // Di chuyển camera đến vị trí mới
    _moveCamera(coordinates);
  }

  /// 🔍 Xử lý kết quả tìm kiếm từ Google Places
  void handleSearchResult(Map<String, dynamic> result) {
    searchQuery.value = result['name'];

    // ✅ Nếu có tọa độ từ Google Places
    if (result['coordinates'] != null) {
      final coords = result['coordinates'];
      final latLng = LatLng(coords['lat'], coords['lng']);

      // Di chuyển camera đến vị trí
      _moveCamera(latLng);

      // Thêm marker tạm thời
      final searchMarker = Marker(
        markerId: MarkerId('search_result'),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: result['name'],
          snippet: result['address'],
        ),
      );

      final updatedMarkers = Set<Marker>.from(markers.value);
      updatedMarkers.removeWhere((m) => m.markerId.value == 'search_result');
      updatedMarkers.add(searchMarker);
      markers.value = updatedMarkers;
    }

    print('Selected location: ${result['name']} - ${result['address']}');
  }

  // ✅ Default address methods
  void setDefaultAddress(String id) {
    print('Setting default address: $id');
    final success = _addressService.setDefaultAddress(id);
    if (success) {
      // Cập nhật ngay lập tức defaultAddressId để trigger UI update
      defaultAddressId.value = id;

      // Force refresh observable list để trigger UI update
      _loadBookingList();
      savedBookingList.refresh(); // Force UI update

      print(
        'Default address updated. New list length: ${savedBookingList.length}',
      );
      //NotificationService.showDefaultAddressSet();
    } else {
      NotificationService.showError(
        'Lỗi',
        'Không thể đặt làm địa chỉ mặc định',
      );
    }
  }

  Map<String, dynamic>? getDefaultAddress() {
    return _addressService.getDefaultAddress();
  }

  void useDefaultAddress() {
    // Đóng dialog hiện tại và mở form điền thông tin
    Get.back();
    _showDetailForm();
  }

  /// 📋 Mở form điền thông tin địa chỉ mới
  void showAddressForm() {
    Get.back(); // Đóng dialog hiện tại
    _showDetailForm(); // Mở form điền thông tin
  }

  // ✅ Fix delete selected bookings method
  void deleteSelectedBookings() {
    // Hiển thị dialog xác nhận trước khi xóa nhiều địa chỉ
    NotificationService.showDeleteConfirmDialog(
      title: 'Xác nhận xóa',
      message:
          'Bạn có chắc muốn xóa ${selectedBookingIds.length} địa chỉ đã chọn?',
    ).then((confirmed) {
      if (confirmed) {
        final removedCount = _addressService.removeMultipleBookingData(
          selectedBookingIds,
        );

        selectedBookingIds.clear();
        isSelectionMode.value = false;
        _loadBookingList(); // Refresh list ngay lập tức

        NotificationService.showMultipleAddressesDeleted(removedCount);
      }
    });
  }

  // ✅ Add missing _useCurrentLocation method
  void _useCurrentLocation() {
    if (currentLocation.value != null) {
      _moveCamera(currentLocation.value!);
      addBookingMarker(currentLocation.value!, 'Vị trí hiện tại');

      // // Get.snackbar(
      // //   'Đã chọn vị trí',
      // //   'Vị trí hiện tại của bạn',
      // //   snackPosition: SnackPosition.BOTTOM,
      // //   backgroundColor: AppColors.primary01,
      // //   colorText: Colors.white,
      // //   duration: Duration(seconds: 2),
      // );
    } else {
      Get.snackbar(
        'Lỗi',
        'Không thể lấy vị trí hiện tại',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }
  }
}

/// 🔧 Extension để thêm method firstWhereOrNull cho List
extension ListExt<T> on List<T> {
  /// 🔍 Tìm phần tử đầu tiên thỏa mãn điều kiện, trả về null nếu không tìm thấy
  T? firstWhereOrNull(bool Function(T) test) {
    for (final item in this) {
      if (test(item)) return item;
    }
    return null;
  }
}

/// 📐 Kiểm tra một điểm có nằm trong polygon không (Point-in-Polygon algorithm)
/// Sử dụng Ray Casting Algorithm
bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
  if (polygon.length < 3) return false; // ❌ Polygon phải có ít nhất 3 điểm

  int intersectCount = 0;

  // 🔄 Kiểm tra giao điểm với từng cạnh của polygon
  for (int j = 0; j < polygon.length; j++) {
    final p1 = polygon[j];
    final p2 =
        polygon[(j + 1) %
            polygon.length]; // 🔗 Đảm bảo nối điểm cuối với điểm đầu

    if (_rayCastIntersect(point, p1, p2)) {
      intersectCount++;
    }
  }

  return (intersectCount % 2 == 1); // 🎯 Lẻ = inside, Chẵn = outside
}

/// ⚡ Kiểm tra tia từ điểm có cắt đoạn thẳng không (Ray Casting)
bool _rayCastIntersect(LatLng point, LatLng vertA, LatLng vertB) {
  final aY = vertA.latitude;
  final bY = vertB.latitude;
  final aX = vertA.longitude;
  final bX = vertB.longitude;
  final pY = point.latitude;
  final pX = point.longitude;

  // ❌ Kiểm tra nếu điểm nằm ngoài phạm vi Y của đoạn thẳng
  if ((aY > pY && bY > pY) || (aY < pY && bY < pY)) {
    return false;
  }

  // ❌ Kiểm tra nếu cả hai điểm đều ở phía tây của điểm test
  if (aX < pX && bX < pX) {
    return false;
  }

  // 📐 Tính toán giao điểm
  if (aX == bX) {
    // 📏 Đường thẳng đứng
    return aX > pX;
  }

  // 📈 Tính slope và tọa độ giao điểm
  final slope = (bY - aY) / (bX - aX);
  final xIntersect = aX + (pY - aY) / slope;

  return xIntersect > pX; // ✅ Giao điểm ở phía đông của điểm test
}
