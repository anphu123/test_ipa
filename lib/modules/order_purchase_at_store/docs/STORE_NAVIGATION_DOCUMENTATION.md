# Store Navigation Documentation

## Overview

Hệ thống chỉ đường đến cửa hàng sử dụng tọa độ latitude và longitude chính xác từ `StoreModel` để cung cấp trải nghiệm điều hướng tốt nhất cho người dùng.

## Architecture

```
StoreModel (lat, lng) → OrderPurchaseAtStoreController → Navigation Methods
                                    ↓
                            Google Maps Integration
```

## Store Coordinate System

### StoreModel Properties
```dart
class StoreModel {
  final double latitude;   // Tọa độ vĩ độ chính xác
  final double longitude;  // Tọa độ kinh độ chính xác
  final String name;       // Tên cửa hàng
  final String district;   // Quận/huyện
  String distance;         // Khoảng cách tính toán
}
```

### Sample Store Coordinates
```dart
// Cửa hàng Trung tâm thành phố
StoreModel(
  id: '1',
  name: '2Hand | Cửa hàng Trung tâm thành phố',
  latitude: 10.762622,   // Quận 1, TP.HCM
  longitude: 106.660172,
  district: 'Quận 1',
)

// Cửa hàng Quận 1
StoreModel(
  id: '2', 
  name: '2Hand | Cửa hàng Quận 1',
  latitude: 10.776889,   // Vị trí khác tại Quận 1
  longitude: 106.700806,
  district: 'Quận 1',
)
```

## Navigation Implementation

### 1. Controller Method
```dart
// OrderPurchaseAtStoreController.navigateToStore()
Future<void> navigateToStore() async {
  final store = currentStore.value;

  if (store != null) {
    // Use real coordinates from selected store
    final lat = store.latitude;
    final lng = store.longitude;
    final storeName = store.name;

    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&destination_place_id=${Uri.encodeComponent(storeName)}'
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        print('🗺️ Navigating to store: $storeName at $lat, $lng');
      }
    } catch (e) {
      // Error handling
    }
  }
}
```

### 2. Widget Integration
```dart
// StaffInfoWidget - Direction Button
GestureDetector(
  onTap: _onNavigateToStore,
  child: Container(
    decoration: BoxDecoration(
      color: AppColors.primary01,
      borderRadius: BorderRadius.circular(4.r),
    ),
    child: Icon(Icons.directions, color: AppColors.white),
  ),
)
```

### 3. Confirmation Dialog
```dart
void _onNavigateToStore() {
  final store = controller.currentStore.value;
  
  if (store != null) {
    Get.dialog(
      AlertDialog(
        title: Text('Chỉ đường đến cửa hàng'),
        content: Column(
          children: [
            Text(store.name),
            Text('${store.name}, ${store.district}'),
            Text('Tọa độ: ${store.latitude}, ${store.longitude}'),
            if (store.distance != '0.0')
              Text('Khoảng cách: ${store.distance} km'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Hủy')),
          ElevatedButton.icon(
            onPressed: () {
              Get.back();
              controller.navigateToStore();
            },
            icon: Icon(Icons.directions),
            label: Text('Chỉ đường'),
          ),
        ],
      ),
    );
  }
}
```

## Google Maps Integration

### URL Format
```
https://www.google.com/maps/dir/?api=1&destination={lat},{lng}&destination_place_id={storeName}
```

### Parameters
- `api=1`: Google Maps URL API
- `destination={lat},{lng}`: Tọa độ đích chính xác
- `destination_place_id={storeName}`: Tên cửa hàng (encoded)

### Example URLs
```
// Cửa hàng Trung tâm thành phố
https://www.google.com/maps/dir/?api=1&destination=10.762622,106.660172&destination_place_id=2Hand%20%7C%20C%E1%BB%ADa%20h%C3%A0ng%20Trung%20t%C3%A2m%20th%C3%A0nh%20ph%E1%BB%91

// Cửa hàng Quận 1
https://www.google.com/maps/dir/?api=1&destination=10.776889,106.700806&destination_place_id=2Hand%20%7C%20C%E1%BB%ADa%20h%C3%A0ng%20Qu%E1%BA%ADn%201
```

## Map Display Integration

### Store Location Marker
```dart
// StoreInfoWidget - Google Maps
Set<Marker> _buildMarkers(LatLng storeLocation) {
  final store = controller.currentStore.value;
  
  return {
    Marker(
      markerId: MarkerId('store_location_${store?.id ?? 'default'}'),
      position: storeLocation, // From store.latitude, store.longitude
      infoWindow: InfoWindow(
        title: store?.name ?? 'Cửa hàng',
        snippet: '${store?.district} • ${store?.openHours}',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
  };
}
```

### Camera Focus
```dart
void _focusOnStoreLocation() {
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
  }
}
```

## User Interface Elements

### 1. Direction Button in StaffInfoWidget
- **Location**: Store info section, next to copy button
- **Design**: Primary color background with white direction icon
- **Size**: 24x24 pixels
- **Action**: Shows confirmation dialog then opens Google Maps

### 2. Bottom Button Navigation
- **Location**: BottomButtonWidget
- **States**: 
  - `confirmed/preparing`: "Đến cửa hàng" button
  - `ready_for_pickup`: "Đến lấy hàng" button
- **Action**: Direct navigation without dialog

### 3. Store Info Dialog
- **Trigger**: Direction button tap
- **Content**: Store name, address, coordinates, distance
- **Actions**: Cancel or Navigate

## Error Handling

### No Store Data
```dart
if (store == null) {
  Get.snackbar(
    'Thông báo',
    'Không tìm thấy thông tin cửa hàng để chỉ đường',
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.AW01,
    colorText: AppColors.white,
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

### Fallback Navigation
```dart
// If no coordinates, use address search
final uri = Uri.parse(
  'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(storeAddress)}'
);
```

## Data Flow Priority

1. **Primary**: `controller.currentStore.value` (from StoreModel)
2. **Secondary**: `controller.orderData['storeLatitude/Longitude']` (from order data)
3. **Fallback**: Address-based search

## Benefits of Coordinate-Based Navigation

✅ **Accuracy**: Exact GPS coordinates ensure precise navigation
✅ **Reliability**: No dependency on address parsing or geocoding
✅ **Performance**: Direct coordinate-to-coordinate routing
✅ **Consistency**: Same location data across map display and navigation
✅ **User Experience**: Faster route calculation and more accurate ETAs

## Integration Points

### StaffInfoWidget
- Direction button in store info section
- Confirmation dialog with store details
- Error handling for missing data

### BottomButtonWidget  
- Main navigation button based on order status
- Direct navigation without confirmation

### StoreInfoWidget
- Map display using same coordinates
- Marker positioning and camera focus
- Consistent location data

## Testing Scenarios

### Valid Store Data
```dart
// Test with complete store information
final testStore = StoreModel(
  id: '1',
  name: '2Hand | Test Store',
  latitude: 10.762622,
  longitude: 106.660172,
  district: 'Quận 1',
  distance: '2.5',
);
```

### Missing Store Data
```dart
// Test with null store
controller.currentStore.value = null;
// Should show error message and not attempt navigation
```

### Invalid Coordinates
```dart
// Test with invalid coordinates
final invalidStore = StoreModel(
  latitude: 0.0,
  longitude: 0.0,
  // ... other properties
);
// Should fallback to address-based navigation
```

This coordinate-based navigation system ensures users always get the most accurate directions to the selected store location.
