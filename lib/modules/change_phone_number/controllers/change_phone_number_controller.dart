import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/otp_service.dart';

class ChangePhoneNumberController extends GetxController{
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  // States
  final RxString phoneCode = ''.obs; // Ví dụ: 84
  final RxInt resendSeconds = 0.obs;
  final RxBool isSendingOtp = false.obs;
  final RxBool isLoading = false.obs;
  Timer? _timer;


  void setPhoneCode(String code) {
    phoneCode.value = code;
  }

  Future<void> sendOtp() async {
    final rawPhone = phoneController.text.trim();
    if (rawPhone.isEmpty || phoneCode.isEmpty) {
      Get.snackbar('Lỗi', 'Vui lòng nhập số điện thoại hợp lệ');
      return;
    }
    // Kiểm tra định dạng (9–10 số, chỉ số)
    final phoneRegex = RegExp(r'^[0-9]{9,10}$');
    if (!phoneRegex.hasMatch(rawPhone)) {
      Get.snackbar('Lỗi', 'Số điện thoại không đúng định dạng');
      return;
    }
    final cleanedPhone =
    rawPhone.startsWith('0') ? rawPhone.substring(1) : rawPhone;
    final fullPhone = '+${phoneCode.value}$cleanedPhone';

    try {
      isSendingOtp.value = true;

      final response = await ApiLoginService.sendOtp(fullPhone);
      if (response.statusCode == 200) {
        Get.snackbar('Thành công', 'Mã OTP đã được gửi tới $fullPhone');
        startCountdown();
      } else {
        Get.snackbar('Lỗi', 'Không thể gửi OTP');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Lỗi khi gửi OTP: $e');
    } finally {
      isSendingOtp.value = false;
    }
  }
  void startCountdown() {
    resendSeconds.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value == 0) {
        timer.cancel();
      } else {
        resendSeconds.value--;
      }
    });
  }



}