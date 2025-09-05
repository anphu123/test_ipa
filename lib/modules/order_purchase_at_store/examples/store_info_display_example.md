# Store Info Display Widget

Tài liệu này mô tả widget hiển thị thông tin cửa hàng đã chọn trong `StaffInfoWidget`.

## UI Layout

```
┌─────────────────────────────────────────────────────┐
│  Cửa hàng 2Hand                    Cách bạn 3km  >  │
│  ┌─────┐  19 Tân Cảng, phường 25, quận        📋   │
│  │     │  Bình Thạnh, TP. Hồ Chí Minh              │
│  │ IMG │                                            │
│  │     │  Giờ mở cửa: 10:00 - 22:00                │
│  └─────┘                                            │
└─────────────────────────────────────────────────────┘
```

## Data Source Priority

### Store Name (`_getStoreName()`)
1. `controller.orderData['storeName']` - Từ Assessment Evaluation
2. `controller.currentStore.value?.name` - Từ selected store
3. `'Cửa hàng 2Hand'` - Default value

### Store Distance (`_getStoreDistance()`)
1. `controller.orderData['storeDistance']` - Từ Assessment Evaluation
2. `controller.currentStore.value?.distance` - Từ selected store
3. `'0'` - Default value
**Format**: `'Cách bạn {distance}km'`

### Store Image (`_getStoreImageUrl()`)
1. `controller.orderData['storeImageUrl']` - Từ Assessment Evaluation
2. `controller.currentStore.value?.imageUrl` - Từ selected store
3. Default Unsplash image - Fallback

### Store Address (`_getStoreAddress()`)
1. `controller.orderData['storeAddress']` - Từ Assessment Evaluation
2. `'19 Tân Cảng, phường 25, quận Bình Thạnh, TP. Hồ Chí Minh'` - Default

### Store Open Hours (`_getStoreOpenHours()`)
1. `controller.orderData['storeOpenHours']` - Từ Assessment Evaluation
2. `controller.currentStore.value?.openHours` - Từ selected store
3. `'10:00 - 22:00'` - Default value

## Example Data Flow

### From AssessmentEvaluationView
```dart
// Data được gửi từ Assessment Evaluation
final storeOrderData = {
  'storeName': '2Hand | Cửa hàng Trung tâm thành phố',
  'storeDistance': '3.2',
  'storeImageUrl': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
  'storeAddress': '19 Tân Cảng, phường 25, quận Bình Thạnh, TP. Hồ Chí Minh',
  'storeOpenHours': '10:00 - 22:00',
  // ... other data
};

Get.toNamed('/order-purchase-at-store', arguments: storeOrderData);
```

### In StaffInfoWidget
```dart
// Widget sẽ hiển thị:
// Header: "2Hand | Cửa hàng Trung tâm thành phố" - "Cách bạn 3.2km >"
// Image: Store photo (60x60)
// Address: "19 Tân Cảng, phường 25, quận Bình Thạnh, TP. Hồ Chí Minh"
// Hours: "Giờ mở cửa: 10:00 - 22:00"
// Copy button: 📋 (clickable)
```

## Code Implementation

### Store Info Widget Structure
```dart
Widget _buildStoreInfo() {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppColors.neutral07,
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Store header (name + distance + chevron)
        _buildStoreHeader(),
        SizedBox(height: 12.h),
        
        // Store details (image + info + copy button)
        _buildStoreDetails(),
      ],
    ),
  );
}
```

### Store Header
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      _getStoreName(), // "Cửa hàng 2Hand"
      style: AppTypography.s16.medium.withColor(AppColors.neutral01),
    ),
    Row(
      children: [
        Text(
          _getStoreDistance(), // "Cách bạn 3km"
          style: AppTypography.s14.regular.withColor(AppColors.neutral03),
        ),
        SizedBox(width: 4.w),
        Icon(Icons.chevron_right, size: 16.r, color: AppColors.neutral03),
      ],
    ),
  ],
),
```

### Store Details
```dart
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Store image (60x60)
    Container(
      width: 60.w,
      height: 60.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        image: DecorationImage(
          image: NetworkImage(_getStoreImageUrl()),
          fit: BoxFit.cover,
        ),
      ),
    ),
    SizedBox(width: 12.w),
    
    // Store info (address + hours)
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getStoreAddress(),
            style: AppTypography.s14.regular.withColor(AppColors.neutral01),
          ),
          SizedBox(height: 8.h),
          Text(
            'Giờ mở cửa: ${_getStoreOpenHours()}',
            style: AppTypography.s12.regular.withColor(AppColors.neutral03),
          ),
        ],
      ),
    ),
    
    // Copy button
    GestureDetector(
      onTap: _onCopyStoreAddress,
      child: Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutral04, width: 1),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
          child: Icon(Icons.copy_outlined, size: 12.r, color: AppColors.neutral03),
        ),
      ),
    ),
  ],
),
```

## Interactive Features

### Copy Store Address
```dart
void _onCopyStoreAddress() {
  // Copy store address to clipboard
  Get.snackbar(
    'Đã sao chép',
    'Địa chỉ cửa hàng đã được sao chép',
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.primary01,
    colorText: AppColors.white,
  );
}
```

## Visual Design

- **Container**: Background `AppColors.neutral07`, rounded corners `8.r`
- **Header Typography**: 
  - Store name: `AppTypography.s16.medium` in `neutral01`
  - Distance: `AppTypography.s14.regular` in `neutral03`
- **Details Typography**:
  - Address: `AppTypography.s14.regular` in `neutral01`
  - Hours: `AppTypography.s12.regular` in `neutral03`
- **Image**: 60x60 with rounded corners `8.r`
- **Copy Button**: 24x24 with border and copy icon
- **Spacing**: 16.w padding, 12.h between sections, 12.w between elements

## Testing Examples

```dart
// Test data 1: Complete store info
{
  'storeName': '2Hand | Cửa hàng Trung tâm thành phố',
  'storeDistance': '3.2',
  'storeImageUrl': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
  'storeAddress': '19 Tân Cảng, phường 25, quận Bình Thạnh, TP. Hồ Chí Minh',
  'storeOpenHours': '10:00 - 22:00',
}
// Result: Full store info display with all details

// Test data 2: Minimal info
{
  'storeName': 'Cửa hàng ABC',
}
// Result: Store name + default values for other fields

// Test data 3: No store info
{}
// Result: All default values
// - Name: "Cửa hàng 2Hand"
// - Distance: "Cách bạn 0km"
// - Address: Default address
// - Hours: "10:00 - 22:00"
```

## Integration with StaffInfoWidget

The store info widget is displayed after the appointment info section:

```dart
// In StaffInfoWidget build method:
Column(
  children: [
    // ... other widgets
    _buildAppointmentInfo(),
    SizedBox(height: 24.h),
    _buildStoreInfo(), // <- Store info widget here
  ],
)
```
