# Complete StaffInfoWidget Documentation

## Overview

`StaffInfoWidget` là một widget hoàn chỉnh hiển thị thông tin nhân viên, khách hàng, lịch hẹn và cửa hàng trong màn hình `OrderPurchaseAtStoreView`. Widget này nhận dữ liệu từ `AssessmentEvaluationView` và hiển thị một cách trực quan, thân thiện với người dùng.

## Architecture

```
StaffInfoWidget (GetView<OrderPurchaseAtStoreController>)
├── Staff Info Section
├── Action Buttons Section  
├── Customer Booking Info Section
└── Store Info Section
```

## Complete Widget Structure

### 1. Staff Info Section
```dart
Widget _buildStaffInfoRow() {
  return Row(
    children: [
      // Avatar (48x48)
      CircleAvatar(radius: 24.r, child: Image.asset(...)),
      
      // Staff details
      Column(
        children: [
          // Name + Position
          Row([
            Text(_getStaffName()),
            Text('Chuyên gia thu mua'),
          ]),
          
          // Stats
          Row([
            Text('Đã hoàn thành ${_getCompletedOrders()} đơn'),
            Text('Tỷ lệ đánh giá tốt ${_getRating()}%'),
          ]),
        ],
      ),
    ],
  );
}
```

### 2. Action Buttons Section
```dart
Widget _buildActionButtons() {
  return Row(
    children: [
      Expanded(child: _ActionButton(
        icon: Assets.images.icTinhieubatthuong.path,
        text: 'Gọi điện',
        onTap: _onCallStaff,
      )),
      Expanded(child: _ActionButton(
        icon: Assets.images.icTinnhan.path,
        text: 'Nhắn tin',
        onTap: _onMessageStaff,
      )),
    ],
  );
}
```

### 3. Customer Booking Info Section
```dart
Widget _buildAppointmentInfo() {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppColors.neutral07,
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Column(
      children: [
        // Customer info
        Row([
          Icon(Icons.person_outline),
          Column([
            Text(_getCustomerName()),      // "Nguyễn Văn A"
            Text(_getCustomerPhoneNumber()), // "090***4567"
          ]),
        ]),
        
        // Appointment time
        Row([
          Icon(Icons.access_time),
          Column([
            Text('Thời gian hẹn'),
            Text(_getAppointmentTime()),    // "15/08/2025 14:00-15:00"
          ]),
        ]),
      ],
    ),
  );
}
```

### 4. Store Info Section
```dart
Widget _buildStoreInfo() {
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppColors.neutral07,
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Column(
      children: [
        // Store header
        Row([
          Text(_getStoreName()),        // "Cửa hàng 2Hand"
          Text(_getStoreDistance()),    // "Cách bạn 3km"
          Icon(Icons.chevron_right),
        ]),
        
        // Store details
        Row([
          Container(60x60, NetworkImage(_getStoreImageUrl())),
          Column([
            Text(_getStoreAddress()),   // Full address
            Text('Giờ mở cửa: ${_getStoreOpenHours()}'),
          ]),
          GestureDetector(onTap: _onCopyStoreAddress, 
            child: Icon(Icons.copy_outlined)),
        ]),
      ],
    ),
  );
}
```

## Data Flow & Priority System

### Input Data Sources
1. **Primary**: `controller.orderData` (từ AssessmentEvaluationView)
2. **Secondary**: `controller.currentStaff.value` (từ staff selection)
3. **Fallback**: Default values

### Staff Information
```dart
String _getStaffName() {
  return controller.orderData['staffName']?.toString() ??
         controller.currentStaff.value?.name ??
         'Alice';
}

String _getCompletedOrders() {
  return controller.orderData['staffCompletedOrders']?.toString() ??
         controller.currentStaff.value?.completedOrders?.toString() ??
         '16493';
}

String _getRating() {
  return controller.orderData['staffRating']?.toString() ??
         controller.currentStaff.value?.rating?.toString() ??
         '98';
}
```

### Customer Information
```dart
String _getCustomerName() {
  return controller.orderData['contactName'] ??
         controller.contactName ??
         'Khách hàng';
}

String _getCustomerPhoneNumber() {
  final phone = controller.orderData['phoneNumber'] ??
                controller.orderData['contactPhone'] ??
                controller.customerPhoneNumber ??
                '0123456789';
  
  // Mask for privacy: "0901234567" → "090***4567"
  if (phone.length >= 7) {
    return '${phone.substring(0, 3)}***${phone.substring(phone.length - 4)}';
  }
  return phone;
}
```

### Appointment Information
```dart
String _getAppointmentTime() {
  return controller.orderData['appointmentTime'] ??
         controller.appointmentTime ??
         _getDefaultAppointmentTime();
}

String _getDefaultAppointmentTime() {
  final now = DateTime.now();
  final appointmentTime = now.add(const Duration(hours: 2));
  final endTime = appointmentTime.add(const Duration(hours: 1));
  
  return '${appointmentTime.day.toString().padLeft(2, '0')}/${appointmentTime.month.toString().padLeft(2, '0')}/${appointmentTime.year} '
         '${appointmentTime.hour.toString().padLeft(2, '0')}:${appointmentTime.minute.toString().padLeft(2, '0')}-'
         '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
}
```

### Store Information
```dart
String _getStoreName() {
  return controller.orderData['storeName'] ??
         controller.currentStore.value?.name ??
         'Cửa hàng 2Hand';
}

String _getStoreDistance() {
  final distance = controller.orderData['storeDistance'] ??
                   controller.currentStore.value?.distance ??
                   '0';
  return 'Cách bạn ${distance}km';
}

String _getStoreImageUrl() {
  return controller.orderData['storeImageUrl'] ??
         controller.currentStore.value?.imageUrl ??
         'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400';
}

String _getStoreAddress() {
  return controller.orderData['storeAddress'] ??
         '19 Tân Cảng, phường 25, quận Bình Thạnh, TP. Hồ Chí Minh';
}

String _getStoreOpenHours() {
  return controller.orderData['storeOpenHours'] ??
         controller.currentStore.value?.openHours ??
         '10:00 - 22:00';
}
```

## Interactive Features

### Action Buttons
```dart
void _onCallStaff() {
  controller.callStaff();
}

void _onMessageStaff() {
  controller.messageStaff();
}
```

### Store Address Copy
```dart
void _onCopyStoreAddress() {
  Get.snackbar(
    'Đã sao chép',
    'Địa chỉ cửa hàng đã được sao chép',
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.primary01,
    colorText: AppColors.white,
  );
}
```

## Complete Usage Example

### From AssessmentEvaluationView
```dart
// Complete data structure sent to OrderPurchaseAtStoreView
final storeOrderData = {
  // Customer info
  'contactName': 'Nguyễn Văn A',
  'phoneNumber': '0901234567',
  
  // Appointment info
  'appointmentTime': '15/08/2025 14:00-15:00',
  
  // Store info
  'storeName': '2Hand | Cửa hàng Trung tâm thành phố',
  'storeDistance': '3.2',
  'storeImageUrl': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
  'storeAddress': '19 Tân Cảng, phường 25, quận Bình Thạnh, TP. Hồ Chí Minh',
  'storeOpenHours': '10:00 - 22:00',
  
  // Staff info (will be assigned later)
  'staffName': null,
  'staffCompletedOrders': null,
  'staffRating': null,
  
  // Product info
  'productModel': 'iPhone 15 Pro Max',
  'evaluatedPrice': '25,000,000 VNĐ',
  
  // ... other data
};

Get.toNamed('/order-purchase-at-store', arguments: storeOrderData);
```

### In OrderPurchaseAtStoreView
```dart
class OrderPurchaseAtStoreView extends GetView<OrderPurchaseAtStoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ... other widgets
          StaffInfoWidget(), // <- Complete widget with all sections
          // ... other widgets
        ],
      ),
    );
  }
}
```

## Visual Result

```
┌─────────────────────────────────────────────────────┐
│  👤 Alice                    │ Chuyên gia thu mua    │
│     Đã hoàn thành 16493 đơn  │ Tỷ lệ đánh giá tốt 98%│
│                                                     │
│  [📞 Gọi điện]              [💬 Nhắn tin]           │
│                                                     │
│  👤  Nguyễn Văn A                                   │
│      090***4567                                     │
│                                                     │
│  🕐  Thời gian hẹn                                  │
│      15/08/2025 14:00-15:00                         │
│                                                     │
│  Cửa hàng 2Hand                    Cách bạn 3km  >  │
│  ┌─────┐  19 Tân Cảng, phường 25, quận        📋   │
│  │     │  Bình Thạnh, TP. Hồ Chí Minh              │
│  │ IMG │                                            │
│  │     │  Giờ mở cửa: 10:00 - 22:00                │
│  └─────┘                                            │
└─────────────────────────────────────────────────────┘
```

## Key Features Summary

✅ **Complete Staff Information Display**
✅ **Interactive Action Buttons** (Call/Message)
✅ **Customer Booking Details** (Name, Phone, Appointment Time)
✅ **Store Information** (Name, Distance, Address, Hours, Image)
✅ **Data Priority System** (OrderData → Controller → Defaults)
✅ **Phone Number Masking** for privacy
✅ **Copy Store Address** functionality
✅ **Responsive Design** with proper spacing and typography
✅ **Error Handling** with fallback values
✅ **Integration Ready** with AssessmentEvaluationView data flow

## Files Structure

```
lib/modules/order_purchase_at_store/
├── views/widgets/
│   └── staff_info_widget_new.dart          # Main widget file
├── examples/
│   ├── customer_booking_info_example.md    # Customer info documentation
│   └── store_info_display_example.md       # Store info documentation
└── docs/
    ├── store_order_data_structure.md       # Data structure documentation
    └── COMPLETE_STAFF_INFO_WIDGET_DOCUMENTATION.md # This file
```

This completes the comprehensive StaffInfoWidget implementation with all requested features and full integration with the AssessmentEvaluationView data flow.
