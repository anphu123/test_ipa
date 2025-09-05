# StaffInfoWidget

Widget hiển thị thông tin nhân viên chuyên gia thu mua tương tự như ShipperInfoWidget.

## Tính năng

- Hiển thị thông tin nhân viên (tên, avatar, số đơn hoàn thành, tỷ lệ đánh giá)
- Thông tin lịch hẹn (thời gian hẹn, số điện thoại)
- Nút thay đổi địa chỉ/thời gian
- Nút gọi điện và nhắn tin
- Badge "Nhận uy tín"
- UI giống hệt như thiết kế

## Cách sử dụng

### 1. Thêm vào Controller

```dart
// Trong OrderPurchaseAtStoreController
String? get staffName => orderData['staffName'] ?? 'Alice';
String? get staffPhoneNumber => orderData['staffPhoneNumber'] ?? '+84901234567';
String? get staffCompletedOrders => orderData['staffCompletedOrders'] ?? '16493';
String? get staffRating => orderData['staffRating'] ?? '98';
```

### 2. Sử dụng Widget

```dart
// Trong OrderBottomSheet hoặc bất kỳ đâu
const StaffInfoWidget(),
```

### 3. Truyền dữ liệu

```dart
// Khi navigate đến OrderPurchaseAtStoreView
Get.toNamed('/order-purchase-at-store', arguments: {
  'staffName': 'Alice',
  'staffPhoneNumber': '+84901234567',
  'staffCompletedOrders': '16493',
  'staffRating': '98',
  'appointmentTime': '12/08/2025 21:00-22:00',
  // ... other order data
});
```

## Cấu trúc dữ liệu

```dart
Map<String, dynamic> staffData = {
  'staffName': 'Alice',                    // Tên nhân viên
  'staffPhoneNumber': '+84901234567',      // Số điện thoại
  'staffCompletedOrders': '16493',         // Số đơn hoàn thành
  'staffRating': '98',                     // Tỷ lệ đánh giá tốt (%)
  'staffId': 'STAFF-001',                  // ID nhân viên (optional)
  'staffPosition': 'Chuyên gia thu mua',   // Chức vụ (optional)
  'staffExperience': '3 năm',              // Kinh nghiệm (optional)
  'staffSpecialty': 'Điện thoại, Laptop',  // Chuyên môn (optional)
};
```

## Tính năng chính

### Avatar
- Hiển thị initials của tên nhân viên
- Màu nền primary
- Tự động tạo từ tên (VD: "Alice" → "A", "Bob Nguyễn" → "BN")

### Thông tin hiển thị
- Tên + chức vụ
- Số đơn hoàn thành + tỷ lệ đánh giá
- Badge "Nhận uy tín"

### Nút hành động
- **Gọi điện**: Mở ứng dụng điện thoại
- **Nhắn tin**: Mở chat hoặc hiển thị thông báo

## Customization

### Thay đổi màu sắc
```dart
// Trong StaffInfoWidget
Container(
  decoration: BoxDecoration(
    color: AppColors.primary01, // Thay đổi màu avatar
  ),
)
```

### Thay đổi layout
```dart
// Có thể tùy chỉnh layout trong build method
Row(
  children: [
    // Avatar
    // Staff info
    // Action buttons
  ],
)
```

## Demo

Xem file `demo/staff_info_demo.dart` để có ví dụ về:
- Dữ liệu mẫu
- Cách navigate với staff data
- Utility functions

## Tích hợp

Widget đã được tích hợp vào:
- `OrderBottomSheet` (hiển thị trong danh sách widget)
- `OrderPurchaseAtStoreController` (quản lý dữ liệu)

## Lưu ý

1. Widget sử dụng dữ liệu từ `controller.orderData`
2. Nếu không có dữ liệu, sẽ hiển thị giá trị mặc định
3. Cần đảm bảo controller được khởi tạo trước khi sử dụng widget
4. Tính năng gọi điện cần package `url_launcher`
