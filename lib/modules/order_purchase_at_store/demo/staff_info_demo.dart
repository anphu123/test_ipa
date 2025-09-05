import 'package:get/get.dart';
import '../domain/staff_model.dart';
import '../domain/mock_staff_data.dart';

/// Demo data for StaffInfoWidget
/// This shows how to pass staff information to the OrderPurchaseAtStoreController
class StaffInfoDemo {
  
  /// Sample staff data that can be passed to the controller
  static Map<String, dynamic> getSampleStaffData() {
    return {
      // Basic order info
      'orderId': 'ORD-2024-001',
      'contactName': 'Nguyễn Văn A',
      'phoneNumber': '0901234567',
      'productModel': 'iPhone 15 Pro Max',
      'productCapacity': '256GB',
      'evaluatedPrice': '25,000,000 VNĐ',
      'storeName': '2Hand | Cửa hàng Trung tâm thành phố',
      'dateTime': '2024-01-15 14:30',
      'pickupDateTime': '2024-01-15 15:00',
      'appointmentTime': '12/08/2025 21:00-22:00',

      // Staff information
      'staffName': 'Alice',
      'staffPhoneNumber': '+84901234567',
      'staffCompletedOrders': '16493',
      'staffRating': '98',
      'staffId': 'STAFF-001',
      'staffPosition': 'Chuyên gia thu mua',
      'staffExperience': '3 năm',
      'staffSpecialty': 'Điện thoại, Laptop, Máy tính bảng',
    };
  }

  /// Alternative staff data for different scenarios
  static Map<String, dynamic> getAlternativeStaffData() {
    return {
      // Basic order info
      'orderId': 'ORD-2024-002',
      'contactName': 'Trần Thị B',
      'phoneNumber': '0987654321',
      'productModel': 'MacBook Pro M3',
      'productCapacity': '512GB',
      'evaluatedPrice': '45,000,000 VNĐ',
      'storeName': '2Hand | Cửa hàng Quận 7',
      'dateTime': '2024-01-15 16:00',
      'pickupDateTime': '2024-01-15 16:30',
      'appointmentTime': '13/08/2025 14:00-15:00',

      // Staff information
      'staffName': 'Bob Nguyễn',
      'staffPhoneNumber': '+84912345678',
      'staffCompletedOrders': '8750',
      'staffRating': '96',
      'staffId': 'STAFF-002',
      'staffPosition': 'Chuyên gia thu mua',
      'staffExperience': '2 năm',
      'staffSpecialty': 'Laptop, Máy ảnh, Thiết bị số',
    };
  }

  /// New staff with less experience
  static Map<String, dynamic> getNewStaffData() {
    return {
      // Basic order info
      'orderId': 'ORD-2024-003',
      'contactName': 'Lê Văn C',
      'phoneNumber': '0976543210',
      'productModel': 'iPad Pro 12.9',
      'productCapacity': '128GB',
      'evaluatedPrice': '18,000,000 VNĐ',
      'storeName': '2Hand | Cửa hàng Thủ Đức',
      'dateTime': '2024-01-15 10:15',
      'appointmentTime': '14/08/2025 10:00-11:00',

      // Staff information
      'staffName': 'Charlie Trần',
      'staffPhoneNumber': '+84923456789',
      'staffCompletedOrders': '1250',
      'staffRating': '94',
      'staffId': 'STAFF-003',
      'staffPosition': 'Chuyên gia thu mua',
      'staffExperience': '6 tháng',
      'staffSpecialty': 'Máy tính bảng, Đồng hồ thông minh',
    };
  }

  /// How to navigate to OrderPurchaseAtStoreView with staff data
  static void navigateToOrderWithStaffInfo({
    Map<String, dynamic>? customData,
  }) {
    final data = customData ?? getSampleStaffData();

    Get.toNamed(
      '/order-purchase-at-store',
      arguments: data,
    );
  }

  /// Navigate with StaffModel
  static void navigateWithStaffModel({
    StaffModel? staff,
  }) {
    final selectedStaff = staff ?? MockStaffData.getRandomStaff();

    final orderData = {
      // Basic order info
      'orderId': 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      'contactName': 'Khách hàng Demo',
      'phoneNumber': '0901234567',
      'productModel': 'iPhone 15 Pro Max',
      'productCapacity': '256GB',
      'evaluatedPrice': '25,000,000 VNĐ',
      'storeName': '2Hand | Cửa hàng Demo',
      'storeAddress': '123 Nguyễn Văn Linh, Quận 7, TP.HCM',
      'dateTime': DateTime.now().toString(),
      'appointmentTime': _generateAppointmentTime(),
      'orderStatus': 'waiting_confirmation',

      // Staff info from model
      'staffId': selectedStaff.id,
      'staffName': selectedStaff.name,
      'staffPhoneNumber': selectedStaff.phoneNumber,
      'staffCompletedOrders': selectedStaff.completedOrders,
      'staffRating': selectedStaff.rating,
      'staffPosition': selectedStaff.position,
      'staffExperience': selectedStaff.experience,
      'staffSpecialty': selectedStaff.specialty,
    };

    Get.toNamed(
      '/order-purchase-at-store',
      arguments: orderData,
    );
  }

  /// Create complete order data for testing
  static Map<String, dynamic> createCompleteOrderData({
    StaffModel? staff,
    String? customAppointmentTime,
  }) {
    final selectedStaff = staff ?? MockStaffData.getRandomStaff();

    return {
      // Order identification
      'orderId': 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      'orderStatus': 'waiting_confirmation',
      'dateTime': DateTime.now().toString(),
      'pickupDateTime': DateTime.now().add(Duration(hours: 1)).toString(),

      // Customer info
      'contactName': 'Nguyễn Văn A',
      'phoneNumber': '0901234567',
      'customerAddress': '456 Lê Văn Việt, Quận 9, TP.HCM',

      // Product info
      'productModel': 'iPhone 15 Pro Max',
      'productCapacity': '256GB',
      'productColor': 'Natural Titanium',
      'evaluatedPrice': '25,000,000 VNĐ',
      'finalPrice': 25000000,

      // Store info
      'storeId': '1',
      'storeName': '2Hand | Cửa hàng Trung tâm',
      'storeAddress': '123 Nguyễn Văn Linh, Quận 7, TP.HCM',
      'storePhoneNumber': '028-1234-5678',

      // Appointment info
      'appointmentTime': customAppointmentTime ?? _generateAppointmentTime(),
      'appointmentType': 'store_visit', // store_visit, home_pickup

      // Staff info
      'staffId': selectedStaff.id,
      'staffName': selectedStaff.name,
      'staffPhoneNumber': selectedStaff.phoneNumber,
      'staffCompletedOrders': selectedStaff.completedOrders,
      'staffRating': selectedStaff.rating,
      'staffPosition': selectedStaff.position,
      'staffExperience': selectedStaff.experience,
      'staffSpecialty': selectedStaff.specialty,

      // Additional info
      'notes': 'Khách hàng yêu cầu kiểm tra kỹ màn hình',
      'paymentMethod': 'cash',
      'voucherId': null,
      'discountAmount': 0,

      // Sample voucher (optional)
      'selectedVoucher': {
        'id': 'VOUCHER_001',
        'name': 'Giảm 5% cho khách hàng mới',
        'type': 'percentage',
        'discountPercentage': 5,
        'discountAmount': null,
        'minOrderValue': 20000000,
        'maxDiscount': 1000000,
        'description': 'Áp dụng cho đơn hàng từ 20 triệu',
        'validUntil': '2025-12-31',
      },
    };
  }

  /// Get all available staff
  static List<StaffModel> getAllStaff() {
    return MockStaffData.mockStaffs;
  }

  /// Get staff by rating
  static List<StaffModel> getTopRatedStaff() {
    return MockStaffData.getTopRatedStaff();
  }

  /// Generate appointment time (2 hours from now)
  static String _generateAppointmentTime() {
    final now = DateTime.now();
    final appointmentTime = now.add(Duration(hours: 2));
    final endTime = appointmentTime.add(Duration(hours: 1));

    return '${appointmentTime.day.toString().padLeft(2, '0')}/${appointmentTime.month.toString().padLeft(2, '0')}/${appointmentTime.year} '
           '${appointmentTime.hour.toString().padLeft(2, '0')}:${appointmentTime.minute.toString().padLeft(2, '0')}-'
           '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
  }

  /// Example of updating staff info during order process
  static void updateStaffInfo(Map<String, dynamic> newStaffData) {
    // This would typically be called when staff is assigned or changed
    // You can update the controller's orderData
    
    // Example usage:
    // final controller = Get.find<OrderPurchaseAtStoreController>();
    // controller.orderData.addAll(newStaffData);
  }

  /// Get staff display name with initials
  static String getStaffInitials(String staffName) {
    if (staffName.isEmpty) return 'S';
    
    final parts = staffName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return staffName[0].toUpperCase();
  }

  /// Format completed orders number
  static String formatCompletedOrders(String orders) {
    try {
      final number = int.parse(orders.replaceAll(',', ''));
      if (number >= 1000) {
        return '${(number / 1000).toStringAsFixed(1)}k';
      }
      return orders;
    } catch (e) {
      return orders;
    }
  }

  /// Get staff experience level based on completed orders
  static String getExperienceLevel(String completedOrders) {
    try {
      final number = int.parse(completedOrders.replaceAll(',', ''));
      if (number >= 10000) {
        return 'Chuyên gia cấp cao';
      } else if (number >= 5000) {
        return 'Chuyên gia';
      } else if (number >= 1000) {
        return 'Có kinh nghiệm';
      } else {
        return 'Mới';
      }
    } catch (e) {
      return 'Chuyên gia';
    }
  }

  /// Get rating color based on percentage
  static String getRatingColor(String rating) {
    try {
      final percentage = int.parse(rating);
      if (percentage >= 95) {
        return 'success'; // Green
      } else if (percentage >= 90) {
        return 'warning'; // Orange
      } else {
        return 'error'; // Red
      }
    } catch (e) {
      return 'success';
    }
  }
}
