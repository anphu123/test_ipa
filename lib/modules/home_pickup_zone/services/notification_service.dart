import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';

/// Service quản lý các thông báo UI
class NotificationService {
  
  /// Hiển thị thông báo thành công
  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }

  /// Hiển thị thông báo lỗi
  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.error, color: Colors.white),
    );
  }

  /// Hiển thị thông báo thông tin
  static void showInfo(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary01,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      icon: Icon(Icons.info, color: Colors.white),
    );
  }

  /// Hiển thị thông báo cảnh báo
  static void showWarning(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.AS01,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
      icon: Icon(Icons.warning, color: Colors.white),
    );
  }

  /// Hiển thị dialog xác nhận
  static Future<bool> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
    Color? confirmColor,
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(
              foregroundColor: confirmColor ?? AppColors.primary01,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Hiển thị dialog xác nhận xóa
  static Future<bool> showDeleteConfirmDialog({
    required String title,
    required String message,
  }) async {
    return showConfirmDialog(
      title: title,
      message: message,
      confirmText: 'Xóa',
      confirmColor: AppColors.error,
    );
  }

  /// Hiển thị loading dialog
  static void showLoading([String? message]) {
    Get.dialog(
      AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Expanded(
              child: Text(message ?? 'Đang xử lý...'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Ẩn loading dialog
  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  /// Hiển thị bottom sheet với custom widget
  static Future<T?> showBottomSheet<T>(Widget child) {
    return Get.bottomSheet<T>(
      child,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Hiển thị thông báo địa chỉ đã được chọn
  // static void showAddressSelected(String address) {
  //   showInfo('Đã chọn địa chỉ', address);
  // }

  /// Hiển thị thông báo địa chỉ đã được xóa
  static void showAddressDeleted([String? address]) {
    showSuccess('Đã xóa', address ?? 'Địa chỉ đã được xóa');
  }

  /// Hiển thị thông báo địa chỉ mặc định đã được đặt
  // static void showDefaultAddressSet() {
  //   showSuccess('Đã cập nhật', 'Đã đặt làm địa chỉ mặc định');
  // }

  /// Hiển thị thông báo không có địa chỉ mặc định
  static void showNoDefaultAddress() {
    showWarning('Thông báo', 'Chưa có địa chỉ mặc định');
  }

  /// Hiển thị thông báo không thể lấy vị trí hiện tại
  static void showLocationError() {
    showError('Lỗi', 'Không thể lấy vị trí hiện tại');
  }

  /// Hiển thị thông báo vị trí hiện tại đã được chọn
  static void showCurrentLocationSelected() {
    showInfo('Đã chọn vị trí', 'Vị trí hiện tại của bạn');
  }

  /// Hiển thị thông báo đã xóa nhiều địa chỉ
  static void showMultipleAddressesDeleted(int count) {
    showSuccess('Đã xóa', 'Đã xóa $count địa chỉ');
  }

  /// Hiển thị thông báo đã xóa tất cả địa chỉ
  static void showAllAddressesCleared() {
    showSuccess('Đã xóa', 'Đã xóa tất cả địa chỉ');
  }

  /// Hiển thị thông báo địa chỉ mặc định đã bị xóa
  static void showDefaultAddressDeleted() {
    showWarning('Thông báo', 'Đã xóa địa chỉ mặc định');
  }
}
