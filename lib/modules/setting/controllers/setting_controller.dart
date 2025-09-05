import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/common_widget/common_popup_confirm.dart';
import '../../../router/app_page.dart';

class SettingController extends GetxController{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GetStorage _storage = GetStorage();

  void handleLogout() {
    Get.dialog(
      CommonPopupConfirm(
        message: 'Xác nhận đăng xuất',
        onConfirm: () async {
          Get.back(); // đóng dialog

          try {
            // 1. Đăng xuất Google
            await _googleSignIn.signOut();

            // 2. Xóa dữ liệu người dùng
            _storage.remove('isLoggedIn');
            _storage.remove('user');
            _storage.remove('loginTime');

            // 3. Điều hướng về màn hình login
            Get.offAllNamed(Routes.loading);
          } catch (e) {
            print('Logout error: $e');
            Get.snackbar('Lỗi', 'Không thể đăng xuất', backgroundColor: Colors.red, colorText: Colors.white);
          }
        },
      ),
    );
  }
}