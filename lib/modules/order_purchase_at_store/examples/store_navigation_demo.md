# Store Navigation Demo - Gửi Tọa Độ Cửa Hàng

## Overview

Demo này minh họa cách hệ thống gửi tọa độ chính xác của cửa hàng khi người dùng click "Chỉ đường".

## Flow Diagram

```
User Click "Chỉ đường" 
        ↓
StaffInfoWidget._onNavigateToStore()
        ↓
Get Store Coordinates from StoreModel
        ↓
controller.navigateToStore()
        ↓
Generate Google Maps URL with Coordinates
        ↓
Launch External Google Maps App
```

## Code Flow

### 1. User Interaction
```dart
// User clicks direction button in StaffInfoWidget
GestureDetector(
  onTap: _onNavigateToStore, // <- Trigger navigation
  child: Container(
    decoration: BoxDecoration(color: AppColors.primary01),
    child: Icon(Icons.directions, color: AppColors.white),
  ),
)
```

### 2. Extract Store Coordinates
```dart
void _onNavigateToStore() {
  // Get store from controller
  final store = controller.currentStore.value;

  if (store != null) {
    // Log coordinates for debugging
    print('🗺️ Navigating to store coordinates:');
    print('📍 Store: ${store.name}');
    print('📍 Latitude: ${store.latitude}');   // e.g., 10.762622
    print('📍 Longitude: ${store.longitude}'); // e.g., 106.660172
    print('📍 District: ${store.district}');
    print('📍 Distance: ${store.distance} km');
    
    // Send coordinates to Google Maps
    controller.navigateToStore();
  }
}
```

### 3. Controller Navigation Method
```dart
Future<void> navigateToStore() async {
  final store = currentStore.value;

  if (store != null) {
    // Extract exact coordinates from StoreModel
    final lat = store.latitude;    // 10.762622
    final lng = store.longitude;   // 106.660172
    final storeName = store.name;  // "2Hand | Cửa hàng Trung tâm thành phố"

    // Build Google Maps URL with coordinates
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&destination_place_id=${Uri.encodeComponent(storeName)}'
    );

    // Launch external Google Maps app
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      print('🗺️ Navigating to store: $storeName at $lat, $lng');
    }
  }
}
```

## Sample Store Data

### Cửa hàng Trung tâm thành phố
```dart
StoreModel(
  id: '1',
  name: '2Hand | Cửa hàng Trung tâm thành phố',
  latitude: 10.762622,   // Tọa độ vĩ độ chính xác
  longitude: 106.660172, // Tọa độ kinh độ chính xác
  district: 'Quận 1',
  distance: '2.5',
)
```

**Generated URL:**
```
https://www.google.com/maps/dir/?api=1&destination=10.762622,106.660172&destination_place_id=2Hand%20%7C%20C%E1%BB%ADa%20h%C3%A0ng%20Trung%20t%C3%A2m%20th%C3%A0nh%20ph%E1%BB%91
```

### Cửa hàng Quận 1
```dart
StoreModel(
  id: '2',
  name: '2Hand | Cửa hàng Quận 1',
  latitude: 10.776889,   // Tọa độ khác
  longitude: 106.700806, // Tọa độ khác
  district: 'Quận 1',
  distance: '3.2',
)
```

**Generated URL:**
```
https://www.google.com/maps/dir/?api=1&destination=10.776889,106.700806&destination_place_id=2Hand%20%7C%20C%E1%BB%ADa%20h%C3%A0ng%20Qu%E1%BA%ADn%201
```

## Console Output Example

```
🗺️ Navigating to store coordinates:
📍 Store: 2Hand | Cửa hàng Trung tâm thành phố
📍 Latitude: 10.762622
📍 Longitude: 106.660172
📍 District: Quận 1
📍 Distance: 2.5 km

🗺️ Navigating to store: 2Hand | Cửa hàng Trung tâm thành phố at 10.762622, 106.660172
```

## User Experience

### 1. Click Direction Button
- User sees direction button (🧭) in store info section
- Button has primary color background with white icon

### 2. Immediate Feedback
- Snackbar appears: "Đang chỉ đường"
- Shows coordinates: "Tọa độ: 10.762622, 106.660172"
- Duration: 3 seconds

### 3. Google Maps Launch
- External Google Maps app opens automatically
- Shows route from current location to exact store coordinates
- Destination marker placed at precise store location

## Coordinate Accuracy Benefits

### ✅ Precise Location
- GPS coordinates ensure exact store location
- No ambiguity from address parsing
- Consistent with map display in app

### ✅ Optimal Routing
- Google Maps calculates best route to exact coordinates
- More accurate ETA and distance
- Better turn-by-turn directions

### ✅ Reliable Navigation
- Works even if store address is incomplete
- Independent of address format variations
- Consistent across different languages/regions

## Error Handling

### No Store Data
```dart
if (store == null) {
  print('❌ No store data available for navigation');
  Get.snackbar(
    'Lỗi',
    'Không tìm thấy tọa độ cửa hàng để chỉ đường',
    backgroundColor: AppColors.AE01,
  );
}
```

### Navigation Failure
```dart
catch (e) {
  print('❌ Error navigating to store: $e');
  Get.snackbar(
    'Lỗi',
    'Không thể mở bản đồ',
    snackPosition: SnackPosition.TOP,
  );
}
```

## Testing Different Stores

### Test Store 1 - Trung tâm thành phố
```dart
// Expected coordinates: 10.762622, 106.660172
// Expected URL: ...destination=10.762622,106.660172...
```

### Test Store 2 - Quận 1
```dart
// Expected coordinates: 10.776889, 106.700806
// Expected URL: ...destination=10.776889,106.700806...
```

### Test Store 3 - Thủ Đức
```dart
// Expected coordinates: 10.870000, 106.800000
// Expected URL: ...destination=10.870000,106.800000...
```

## Integration Points

### StaffInfoWidget
- Direction button triggers coordinate extraction
- Shows snackbar with coordinates
- Calls controller navigation method

### OrderPurchaseAtStoreController
- Maintains currentStore with coordinates
- Builds Google Maps URL with exact coordinates
- Handles external app launch

### StoreModel
- Provides precise latitude/longitude
- Consistent coordinate source
- Used across map display and navigation

## URL Parameters Explained

```
https://www.google.com/maps/dir/?api=1&destination=10.762622,106.660172&destination_place_id=2Hand%20Store
```

- `api=1`: Google Maps URL API
- `destination=lat,lng`: Exact coordinates (most important!)
- `destination_place_id=name`: Store name for context (encoded)

The coordinates are the primary navigation target, ensuring users reach the exact store location regardless of address variations or geocoding issues.

## Summary

Khi user click "Chỉ đường":
1. **Extract**: Lấy tọa độ chính xác từ `StoreModel`
2. **Log**: Hiển thị coordinates trong console
3. **Build**: Tạo Google Maps URL với coordinates
4. **Launch**: Mở Google Maps với destination chính xác
5. **Feedback**: Hiển thị snackbar với coordinates cho user

Hệ thống đảm bảo user luôn được dẫn đến đúng vị trí cửa hàng với độ chính xác GPS!
