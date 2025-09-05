# HomePickupZone Module - Maintenance Documentation

## 📋 Overview

The HomePickupZone module manages the map-based pickup zone functionality, allowing users to view pickup zones, book home pickup services, and manage saved addresses. This module has been refactored to follow clean architecture principles with clear separation of concerns.

## 🏗️ Architecture

### Layer Structure
```
┌─────────────────────────────────────────┐
│                 UI Layer                │
│  ┌─────────────────┐ ┌─────────────────┐│
│  │    Widgets      │ │     Views       ││
│  └─────────────────┘ └─────────────────┘│
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│              Business Layer             │
│  ┌─────────────────┐ ┌─────────────────┐│
│  │   Controllers   │ │    Domain       ││
│  └─────────────────┘ └─────────────────┘│
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│               Service Layer             │
│  ┌─────────────────┐ ┌─────────────────┐│
│  │   Data Services │ │ UI Services     ││
│  └─────────────────┘ └─────────────────┘│
└─────────────────────────────────────────┘
```

## 📁 File Structure

```
lib/modules/home_pickup_zone/
├── controllers/
│   └── home_pickup_zone_controller.dart    # Main business logic
├── services/
│   ├── booking_address_service.dart        # Data operations
│   └── notification_service.dart           # UI notifications
├── widgets/
│   ├── booking_address_list_widget.dart    # Address list UI
│   ├── zone_details_widget.dart            # Zone info UI
│   └── pickup_booking_form.dart            # Booking form
├── domain/
│   ├── pickup_zone_model.dart              # Data models
│   └── pickup_zone_repository.dart         # Data access
└── views/
    └── home_pickup_zone_view.dart          # Main view
```

## 🎯 Core Components

### 1. HomePickupZoneController
**Purpose**: Manages business logic and state for pickup zones and address booking.

**Key Responsibilities**:
- Map interaction and zone display
- User location management
- Address booking coordination
- State management for UI components

**Important Methods**:
```dart
// Core business methods
Future<void> bookHomePickup()           // Initiates booking process
void showBookingDialog()                // Shows address selection UI
Map<String, dynamic>? getDefaultAddress() // Gets default address
void setDefaultAddress(String id)       // Sets address as default

// Address management
void addBookingData(Map<String, dynamic> data)
void removeBookingData(String id)
void clearAllBookingData()

// Location and zone methods
PickupZoneModel? getCurrentPickupZone()
bool isAddressInPickupZone(LatLng address)
void getCurrentLocation()
```

### 2. BookingAddressService
**Purpose**: Handles all data operations for saved addresses.

**Key Methods**:
```dart
List<Map<String, dynamic>> getBookingList()
void addBookingData(Map<String, dynamic> data)
bool removeBookingData(String id)
Map<String, dynamic>? getDefaultAddress()
bool setDefaultAddress(String id)
```

### 3. NotificationService
**Purpose**: Manages all UI notifications and dialogs.

**Key Methods**:
```dart
static void showSuccess(String title, String message)
static void showError(String title, String message)
static void showInfo(String title, String message)
static Future<bool> showConfirmDialog({...})
```

## 🔧 Maintenance Guidelines

### Adding New Features

#### 1. Adding a New Address Operation
```dart
// 1. Add method to BookingAddressService
class BookingAddressService {
  bool updateBookingData(String id, Map<String, dynamic> data) {
    // Implementation
  }
}

// 2. Add business logic to Controller
class HomePickupZoneController {
  void updateAddress(String id, Map<String, dynamic> data) {
    final success = _addressService.updateBookingData(id, data);
    if (success) {
      _loadBookingList();
      NotificationService.showSuccess('Cập nhật', 'Địa chỉ đã được cập nhật');
    }
  }
}

// 3. Update UI widget if needed
class BookingAddressListWidget {
  // Add new callback parameter
  final Function(String, Map<String, dynamic>)? onAddressUpdated;
}
```

#### 2. Adding New Zone Features
```dart
// 1. Update PickupZoneModel if needed
class PickupZoneModel {
  final String newProperty;
  // Add to constructor and fromJson/toJson
}

// 2. Add business logic to Controller
void handleNewZoneFeature(PickupZoneModel zone) {
  // Business logic here
}

// 3. Update UI components
class ZoneDetailsWidget {
  // Add new UI elements
}
```

### Modifying Existing Features

#### 1. Changing Address Storage Format
```dart
// 1. Update BookingAddressService
class BookingAddressService {
  // Add migration logic in constructor or init method
  void _migrateOldData() {
    final oldData = _storage.read('old_key');
    if (oldData != null) {
      // Convert and save in new format
      _storage.write('pickup_booking_list', convertedData);
      _storage.remove('old_key');
    }
  }
}
```

#### 2. Updating Notification Messages
```dart
// Update NotificationService methods
class NotificationService {
  static void showAddressDeleted([String? address]) {
    showSuccess('Đã xóa', address ?? 'Địa chỉ đã được xóa thành công');
  }
}
```

### Testing Guidelines

#### 1. Unit Testing Controller
```dart
// Test business logic separately
void main() {
  group('HomePickupZoneController', () {
    late HomePickupZoneController controller;
    late MockBookingAddressService mockService;
    
    setUp(() {
      mockService = MockBookingAddressService();
      controller = HomePickupZoneController();
      // Inject mock service
    });
    
    test('should add booking data correctly', () {
      // Test implementation
    });
  });
}
```

#### 2. Widget Testing
```dart
// Test UI components separately
void main() {
  testWidgets('BookingAddressListWidget displays addresses', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BookingAddressListWidget(
          bookingList: mockBookingList,
          onAddressSelected: (address) {},
          // ... other callbacks
        ),
      ),
    );
    
    expect(find.text('Address 1'), findsOneWidget);
  });
}
```

## ⚠️ Common Issues and Solutions

### 1. Memory Leaks
**Problem**: Controller not disposing properly
**Solution**: 
```dart
@override
void onClose() {
  mapController?.dispose();
  _searchDebounceTimer?.cancel();
  super.onClose();
}
```

### 2. State Synchronization
**Problem**: UI not updating after data changes
**Solution**: Always call `_loadBookingList()` after data operations
```dart
void removeBookingData(String id) {
  final removed = _addressService.removeBookingData(id);
  if (removed) {
    _loadBookingList(); // Essential for UI sync
  }
}
```

### 3. Location Permission Issues
**Problem**: Location access denied
**Solution**: Handle all permission states
```dart
Future<void> getCurrentLocation() async {
  try {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        NotificationService.showError('Lỗi', 'Quyền truy cập vị trí bị từ chối');
        return;
      }
    }
    // Continue with location logic
  } catch (e) {
    NotificationService.showError('Lỗi', 'Không thể lấy vị trí: $e');
  }
}
```

## 🚀 Performance Optimization

### 1. Lazy Loading
```dart
// Load data only when needed
void _loadBookingListIfNeeded() {
  if (savedBookingList.isEmpty) {
    _loadBookingList();
  }
}
```

### 2. Debouncing
```dart
// Already implemented for search
void updateSearchQuery(String query) {
  searchQuery.value = query;
  _searchDebounceTimer?.cancel();
  _searchDebounceTimer = Timer(Duration(milliseconds: 500), () {
    _performSearch(query);
  });
}
```

### 3. Memory Management
```dart
// Clear large data when not needed
void clearMapData() {
  serviceZones.clear();
  markers.clear();
}
```

## 📝 Code Style Guidelines

### 1. Method Naming
- Public methods: `camelCase` (e.g., `bookHomePickup()`)
- Private methods: `_camelCase` (e.g., `_loadBookingList()`)
- UI methods: descriptive names (e.g., `showBookingDialog()`)

### 2. Error Handling
```dart
// Always use try-catch for external operations
try {
  final result = await externalOperation();
  // Handle success
} catch (e) {
  NotificationService.showError('Lỗi', 'Mô tả lỗi: $e');
}
```

### 3. Documentation
```dart
/// 📅 Xử lý đặt lịch thu mua tại nhà
/// 
/// Kiểm tra vị trí hiện tại và hiển thị dialog phù hợp
/// - Nếu trong zone: hiển thị thông tin zone
/// - Nếu ngoài zone: vẫn cho phép đặt lịch
Future<void> bookHomePickup() async {
  final zone = getCurrentPickupZone();
  showBookingDialog(zone);
}
```

## 🔄 Migration Guide

When updating this module, follow these steps:

1. **Backup**: Always backup current data structure
2. **Test**: Test migration logic thoroughly
3. **Gradual**: Implement changes gradually
4. **Rollback**: Have rollback plan ready

## 📞 Support

For questions or issues:
- Check this documentation first
- Review code comments in the files
- Test changes in development environment
- Follow the established patterns

## 📊 Data Flow Diagram

```
User Action → Controller → Service → Storage
     ↓           ↓          ↓         ↓
UI Update ← Notification ← Result ← Data
```

### Example: Adding New Address
```
1. User fills form → BookingAddressListWidget
2. Form validation → Controller.addBookingData()
3. Data processing → BookingAddressService.addBookingData()
4. Storage operation → GetStorage.write()
5. Success feedback → NotificationService.showSuccess()
6. UI refresh → Controller._loadBookingList()
```

## 🔍 Debugging Guide

### 1. Address Not Saving
**Check**:
- `BookingAddressService.addBookingData()` is called
- Data format matches expected structure
- Storage permissions are available
- No exceptions in console

**Debug Steps**:
```dart
// Add debug prints
void addBookingData(Map<String, dynamic> data) {
  print('Adding booking data: $data');
  _addressService.addBookingData(data);
  print('Data added, refreshing list...');
  _loadBookingList();
  print('Current list size: ${savedBookingList.length}');
}
```

### 2. Map Not Loading
**Check**:
- Google Maps API key is valid
- Internet connection is available
- Location permissions are granted
- `getCurrentLocation()` is called

### 3. UI Not Updating
**Check**:
- Observable variables are used (`.obs`)
- `Obx()` or `GetX()` widgets wrap reactive UI
- `_loadBookingList()` is called after data changes

## 🛡️ Security Considerations

### 1. Data Validation
```dart
bool validateBookingData(Map<String, dynamic> data) {
  if (data['contactName']?.toString().trim().isEmpty ?? true) return false;
  if (data['phoneNumber']?.toString().trim().isEmpty ?? true) return false;
  if (data['fullAddress']?.toString().trim().isEmpty ?? true) return false;
  return true;
}
```

### 2. Location Privacy
- Always request permission before accessing location
- Don't store precise coordinates unnecessarily
- Allow users to opt-out of location services

### 3. Input Sanitization
```dart
String sanitizeInput(String input) {
  return input.trim().replaceAll(RegExp(r'[<>\"\'&]'), '');
}
```

---

**Last Updated**: 2025-01-31
**Version**: 2.0.0 (Clean Architecture)
**Maintainer**: Development Team
