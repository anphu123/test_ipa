# Store Order Data Structure

Tài liệu này mô tả cấu trúc dữ liệu được gửi từ `AssessmentEvaluationView` đến `OrderPurchaseAtStoreView` khi người dùng chọn "Thu mua tại cửa hàng".

## Cấu trúc dữ liệu hoàn chỉnh

### 1. Thông tin sản phẩm (Product Info)
```dart
{
  // Product details from EvaluateResultModel
  'productModel': 'iPhone 15 Pro Max',
  'productCapacity': '256GB', 
  'productVersion': 'Quốc tế',
  'warranty': 'Còn bảo hành',
  'lockStatus': 'Đã mở khóa',
  'cloudStatus': 'Đã đăng xuất',
  'batteryStatus': '85%',
  'appearance': 'Tốt',
  'display': 'Hoàn hảo',
  'repair': 'Chưa sửa chữa',
  'screenRepair': 'Chưa thay màn hình',
  'functionality': [...], // List of functionality checks
  'evaluatedPrice': '25,000,000 VNĐ',
}
```

### 2. Thông tin cửa hàng (Store Info)
```dart
{
  // Store details from StoreModel
  'storeId': '1',
  'storeName': '2Hand | Cửa hàng Trung tâm thành phố',
  'storeDescription': 'Lorem ipsum dolor sit amet...',
  'storeImageUrl': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
  'storeDistrict': 'Quận 1',
  'storeLatitude': 10.762622,
  'storeLongitude': 106.660172,
  'storeOpenHours': '10:00 - 21:30',
  'storeServices': ['Điện thoại', 'Laptop', 'Máy tính bảng', ...],
  'storeCategories': ['Điện thoại', 'Laptop', 'Thiết bị số'],
  'storeDistance': '0.0',
  'storeAddress': '2Hand | Cửa hàng Trung tâm thành phố, Quận 1',
  'storePhoneNumber': '+84 123456789', // Default value
}
```

### 3. Thông tin liên hệ khách hàng (Customer Contact)
```dart
{
  // Customer contact from form input
  'contactName': 'Nguyễn Văn A', // From storeContactName
  'phoneNumber': '0901234567',   // From storePhoneNumber
}
```

### 4. Thông tin lịch hẹn (Appointment Info)
```dart
{
  // Appointment details
  'appointmentTime': '15/08/2025 14:00-15:00', // Formatted datetime
  'appointmentDate': '15/08/2025',             // Date only
  'appointmentTimeSlot': '14:00-15:00',        // Time slot only
}
```

### 5. Thông tin phương thức (Pickup Method)
```dart
{
  // Pickup method details
  'pickupMethod': 'store_pickup',
  'pickupMethodName': 'Thu mua tại cửa hàng',
  'selectedPickupMethodIndex': 0,
  'pickupMethodOptions': [
    'Thu mua tại cửa hàng',
    'Thu mua tại nhà', 
    'Gửi hàng thu mua'
  ],
}
```

### 6. Thông tin nhân viên (Staff Info - Future)
```dart
{
  // Staff information (will be assigned later)
  'staffId': null,
  'staffName': null,
  'staffPhoneNumber': null,
  'staffCompletedOrders': null,
  'staffRating': null,
}
```

### 7. Thông tin voucher (Voucher Info)
```dart
{
  // Voucher details if selected
  'selectedVoucher': {
    'id': 'VOUCHER_001',
    'amount': 'Giảm 5%',
    'condition': 'Đơn hàng từ 20 triệu',
    'expiry': '31/12/2025',
    'expiryDate': '2025-12-31',
    'status': 'available',
    'discountAmount': null,
    'discountPercentage': 5,
  } // null if no voucher selected
}
```

### 8. Metadata và validation (Metadata & Validation)
```dart
{
  // Assessment evaluation data
  'evaluationId': '1734567890123',
  'evaluationTime': '2024-12-18T10:30:00.000Z',
  'remainingTime': '23:45:30',
  
  // Order metadata
  'orderType': 'store_pickup',
  'createdAt': '2024-12-18T10:30:00.000Z',
  'orderSource': 'assessment_evaluation',
  
  // Validation flags
  'isStoreInfoValid': true,
  'hasSelectedStore': true,
  'hasValidAppointment': true,
  
  // Form validation states
  'formValidation': {
    'isStoreContactNameValid': true,
    'isStorePhoneNumberValid': true,
    'storeContactNameError': null,
    'storePhoneNumberError': null,
  },
}
```

### 9. Preferences và navigation (Preferences & Navigation)
```dart
{
  // Customer preferences
  'preferredLanguage': 'vi',
  'specialRequests': '',
  'notificationPreferences': {
    'sms': true,
    'email': false,
    'push': true,
  },
  
  // Navigation info
  'navigationSource': 'assessment_evaluation',
  'previousRoute': '/assessment-evaluation',
  'canGoBack': true,
}
```

## Cách sử dụng trong OrderPurchaseAtStoreController

```dart
class OrderPurchaseAtStoreController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      orderData.value = arguments;
      
      // Access store info
      final storeId = orderData['storeId'];
      final storeName = orderData['storeName'];
      
      // Access customer contact
      final contactName = orderData['contactName'];
      final phoneNumber = orderData['phoneNumber'];
      
      // Access appointment
      final appointmentTime = orderData['appointmentTime'];
      
      // Access product info
      final productModel = orderData['productModel'];
      final evaluatedPrice = orderData['evaluatedPrice'];
      
      // Access voucher
      final selectedVoucher = orderData['selectedVoucher'];
      
      // Access validation flags
      final isValid = orderData['isStoreInfoValid'];
      final hasStore = orderData['hasSelectedStore'];
    }
  }
}
```

## Debug Information

Khi navigate, console sẽ hiển thị:
```
🏪 Complete Store Order Data:
Store ID: 1
Store Name: 2Hand | Cửa hàng Trung tâm thành phố
Contact Name: Nguyễn Văn A
Phone Number: 0901234567
Appointment Time: 15/08/2025 14:00-15:00
Product Model: iPhone 15 Pro Max
Evaluated Price: 25,000,000 VNĐ
Order Type: store_pickup
Has Voucher: true
```

## Lưu ý quan trọng

1. **Store Phone Number**: Hiện tại sử dụng default value vì `StoreModel` chưa có property `phoneNumber`
2. **Staff Info**: Được set null và sẽ được assign sau trong `OrderPurchaseAtStoreView`
3. **Validation**: Tất cả validation states được truyền để UI có thể hiển thị errors nếu cần
4. **Voucher**: Chỉ có data nếu user đã chọn voucher trong assessment
5. **Navigation**: Có thể quay lại assessment view nếu cần
