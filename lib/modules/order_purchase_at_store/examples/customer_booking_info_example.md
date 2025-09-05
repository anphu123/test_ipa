# Customer Booking Info Display

Tài liệu này mô tả cách `StaffInfoWidget` hiển thị thông tin người đặt lịch hẹn và thời gian hẹn.

## UI Layout

```
┌─────────────────────────────────────────────────────┐
│  Customer Booking Info                              │
│  ┌─────────────────────────────────────────────────┐│
│  │ 👤  Nguyễn Văn A                               ││
│  │     034***1234                                 ││
│  │                                                ││
│  │ 🕐  Thời gian hẹn                              ││
│  │     15/08/2025 14:00-15:00                     ││
│  └─────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────┘
```

## Data Source Priority

### Customer Name (`_getCustomerName()`)
1. `controller.orderData['contactName']` - Từ Assessment Evaluation
2. `controller.contactName` - Từ controller getter
3. `'Khách hàng'` - Default value

### Customer Phone (`_getCustomerPhoneNumber()`)
1. `controller.orderData['phoneNumber']` - Từ Assessment Evaluation
2. `controller.orderData['contactPhone']` - Alternative key
3. `controller.customerPhoneNumber` - Từ controller getter
4. `'0123456789'` - Default value

**Phone Masking**: `0901234567` → `090***4567`

### Appointment Time (`_getAppointmentTime()`)
1. `controller.orderData['appointmentTime']` - Từ Assessment Evaluation
2. `controller.appointmentTime` - Từ controller getter
3. `_getDefaultAppointmentTime()` - Generated default (2 hours from now)

## Example Data Flow

### From AssessmentEvaluationView
```dart
// Data được gửi từ Assessment Evaluation
final storeOrderData = {
  'contactName': 'Nguyễn Văn A',           // Tên người đặt
  'phoneNumber': '0901234567',             // SĐT người đặt
  'appointmentTime': '15/08/2025 14:00-15:00', // Thời gian hẹn
  // ... other data
};

Get.toNamed('/order-purchase-at-store', arguments: storeOrderData);
```

### In StaffInfoWidget
```dart
// Widget sẽ hiển thị:
// 👤 Nguyễn Văn A
//    090***4567
//
// 🕐 Thời gian hẹn  
//    15/08/2025 14:00-15:00
```

## Code Implementation

### Customer Info Section
```dart
// Customer name and phone
Row(
  children: [
    Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.neutral04, width: 2),
      ),
      child: Center(
        child: Icon(Icons.person_outline, size: 16.r, color: AppColors.neutral04),
      ),
    ),
    SizedBox(width: 12.w),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getCustomerName(), // "Nguyễn Văn A"
            style: AppTypography.s14.medium.copyWith(color: AppColors.neutral01),
          ),
          Text(
            _getCustomerPhoneNumber(), // "090***4567"
            style: AppTypography.s12.regular.copyWith(color: AppColors.neutral03),
          ),
        ],
      ),
    ),
  ],
),
```

### Appointment Time Section
```dart
// Appointment time
Row(
  children: [
    Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.neutral04, width: 2),
      ),
      child: Center(
        child: Icon(Icons.access_time, size: 16.r, color: AppColors.neutral04),
      ),
    ),
    SizedBox(width: 12.w),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thời gian hẹn',
            style: AppTypography.s12.regular.copyWith(color: AppColors.neutral03),
          ),
          Text(
            _getAppointmentTime(), // "15/08/2025 14:00-15:00"
            style: AppTypography.s14.medium.copyWith(color: AppColors.neutral01),
          ),
        ],
      ),
    ),
  ],
),
```

## Helper Methods

### Phone Number Masking
```dart
String _getCustomerPhoneNumber() {
  final phone = controller.orderData['phoneNumber'] ?? '0123456789';
  
  // Mask phone number for privacy
  if (phone.length >= 7) {
    return '${phone.substring(0, 3)}***${phone.substring(phone.length - 4)}';
  }
  return phone;
}
```

### Default Appointment Time Generation
```dart
String _getDefaultAppointmentTime() {
  final now = DateTime.now();
  final appointmentTime = now.add(Duration(hours: 2));
  final endTime = appointmentTime.add(Duration(hours: 1));
  
  return '${appointmentTime.day.toString().padLeft(2, '0')}/${appointmentTime.month.toString().padLeft(2, '0')}/${appointmentTime.year} '
         '${appointmentTime.hour.toString().padLeft(2, '0')}:${appointmentTime.minute.toString().padLeft(2, '0')}-'
         '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
}
```

## Visual Design

- **Container**: Background `AppColors.neutral07`, rounded corners `8.r`
- **Icons**: Circle border with `person_outline` and `access_time` icons
- **Typography**: 
  - Name: `AppTypography.s14.medium` in `neutral01`
  - Phone: `AppTypography.s12.regular` in `neutral03`
  - Label: `AppTypography.s12.regular` in `neutral03`
  - Time: `AppTypography.s14.medium` in `neutral01`
- **Spacing**: 16.h between sections, 12.w between icon and text

## Testing Examples

```dart
// Test data 1: Complete info
{
  'contactName': 'Nguyễn Văn A',
  'phoneNumber': '0901234567',
  'appointmentTime': '15/08/2025 14:00-15:00',
}
// Result: 👤 Nguyễn Văn A / 090***4567 / 🕐 15/08/2025 14:00-15:00

// Test data 2: Missing info
{
  'contactName': null,
  'phoneNumber': null,
  'appointmentTime': null,
}
// Result: 👤 Khách hàng / 012***6789 / 🕐 [Generated time]

// Test data 3: Short phone
{
  'phoneNumber': '123',
}
// Result: 👤 Khách hàng / 123 / 🕐 [Generated time]
```
