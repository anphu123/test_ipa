# HomePickupZone - Quick Reference Guide

## 🚀 Quick Start

### Adding New Address Operation
```dart
// 1. Service Layer
class BookingAddressService {
  bool yourNewMethod(String id, Map<String, dynamic> data) {
    // Data operation logic
    final bookingList = getBookingList();
    // ... modify bookingList
    saveBookingList(bookingList);
    return true;
  }
}

// 2. Controller Layer  
class HomePickupZoneController {
  void yourNewFeature(String id, Map<String, dynamic> data) {
    final success = _addressService.yourNewMethod(id, data);
    if (success) {
      _loadBookingList(); // Always refresh
      NotificationService.showSuccess('Title', 'Message');
    }
  }
}

// 3. UI Layer (if needed)
class BookingAddressListWidget {
  final Function(String, Map<String, dynamic>)? onYourNewAction;
  
  // Use in widget:
  onPressed: () => onYourNewAction?.call(id, data),
}
```

## 📋 Common Tasks

### 1. Modify Address Display
**File**: `lib/modules/home_pickup_zone/widgets/booking_address_list_widget.dart`
**Method**: `_buildAddressItem()`

### 2. Change Storage Format
**File**: `lib/modules/home_pickup_zone/services/booking_address_service.dart`
**Add migration in constructor**

### 3. Update Notifications
**File**: `lib/modules/home_pickup_zone/services/notification_service.dart`
**Modify static methods**

### 4. Add Map Features
**File**: `lib/modules/home_pickup_zone/controllers/home_pickup_zone_controller.dart`
**Add methods in map section**

## 🔧 Key Methods Reference

### Controller Methods
```dart
// Address Management
addBookingData(Map<String, dynamic> data)
removeBookingData(String id)
setDefaultAddress(String id)
getDefaultAddress() → Map<String, dynamic>?

// UI Actions
showBookingDialog([PickupZoneModel? zone])
bookHomePickup()

// Location & Zones
getCurrentPickupZone() → PickupZoneModel?
isAddressInPickupZone(LatLng address) → bool
getCurrentLocation()

// State Management
toggleSelectionMode()
toggleBookingSelection(String id)
```

### Service Methods
```dart
// BookingAddressService
getBookingList() → List<Map<String, dynamic>>
addBookingData(Map<String, dynamic> data)
removeBookingData(String id) → bool
setDefaultAddress(String id) → bool
getDefaultAddress() → Map<String, dynamic>?

// NotificationService
showSuccess(String title, String message)
showError(String title, String message)
showConfirmDialog({...}) → Future<bool>
```

## 🎯 Data Structure

### Address Data Format
```dart
{
  'id': 'unique_timestamp_string',
  'contactName': 'Nguyen Van A',
  'phoneNumber': '0123456789',
  'fullAddress': 'Full address string',
  'latitude': 10.762622,
  'longitude': 106.660172,
  'isDefault': false,
  'isInZone': true,
  'createdAt': 1640995200000,
}
```

### Zone Data Format
```dart
PickupZoneModel {
  String id;
  String name;
  String description;
  List<LatLng> boundaries;
  LatLng center;
  bool isActive;
  String operatingHours;
}
```

## ⚡ Performance Tips

### 1. Lazy Loading
```dart
// Only load when needed
if (savedBookingList.isEmpty) {
  _loadBookingList();
}
```

### 2. Debouncing
```dart
Timer? _debounceTimer;
void onSearchChanged(String query) {
  _debounceTimer?.cancel();
  _debounceTimer = Timer(Duration(milliseconds: 500), () {
    performSearch(query);
  });
}
```

### 3. Memory Management
```dart
@override
void onClose() {
  mapController?.dispose();
  _debounceTimer?.cancel();
  super.onClose();
}
```

## 🐛 Common Issues

### Issue: UI not updating after data change
**Solution**: Call `_loadBookingList()` after service operations
```dart
void removeAddress(String id) {
  _addressService.removeBookingData(id);
  _loadBookingList(); // ← Essential!
}
```

### Issue: Location permission denied
**Solution**: Handle all permission states
```dart
if (permission == LocationPermission.denied) {
  permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    NotificationService.showError('Lỗi', 'Cần quyền truy cập vị trí');
    return;
  }
}
```

### Issue: Memory leak
**Solution**: Dispose resources properly
```dart
@override
void onClose() {
  mapController?.dispose();
  _searchDebounceTimer?.cancel();
  super.onClose();
}
```

## 🧪 Testing Checklist

### Unit Tests
- [ ] Address CRUD operations
- [ ] Default address logic
- [ ] Zone detection logic
- [ ] Location permission handling

### Widget Tests  
- [ ] Address list display
- [ ] Selection mode functionality
- [ ] Form validation
- [ ] Button interactions

### Integration Tests
- [ ] End-to-end booking flow
- [ ] Map interaction
- [ ] Data persistence
- [ ] Error scenarios

## 📱 UI Components

### BookingAddressListWidget
**Purpose**: Display and manage saved addresses
**Key Props**: `bookingList`, `onAddressSelected`, `onAddressDeleted`

### ZoneDetailsWidget  
**Purpose**: Show zone information
**Key Props**: `zone`, `onBookPickup`, `onViewRules`

### PickupBookingForm
**Purpose**: Add new address
**Key Features**: Address validation, zone checking, form submission

## 🔄 State Management

### Observable Variables
```dart
final savedBookingList = <Map<String, dynamic>>[].obs;
final isSelectionMode = false.obs;
final selectedBookingIds = <String>{}.obs;
final currentLocation = Rxn<LatLng>();
```

### State Updates
```dart
// Always use .value for updates
isSelectionMode.value = true;
selectedBookingIds.add(id);
savedBookingList.refresh(); // Force UI update
```

## 📞 Emergency Fixes

### Quick Disable Feature
```dart
// In controller method
void problematicMethod() {
  // return; // ← Quick disable
  // Original code...
}
```

### Reset All Data
```dart
void resetAllData() {
  _addressService.clearAllBookingData();
  savedBookingList.clear();
  selectedBookingIds.clear();
  isSelectionMode.value = false;
}
```

### Force Refresh
```dart
void forceRefresh() {
  _loadBookingList();
  getCurrentLocation();
  _loadData();
}
```

---
**Quick Reference v2.0** | **Last Updated**: 2025-01-31
