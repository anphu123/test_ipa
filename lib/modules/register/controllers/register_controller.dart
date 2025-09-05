import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/extensions/string_extension.dart';
import '../../../services/api_service.dart';

class RegisterController extends GetxController {
  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
//  final RxBool isTermsAccepted = false.obs;


  // Observables for errors
  final RxString nameError = ''.obs;
  final RxString mailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  final apiService = ApiService();

  // UI state
  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;

  // Toggle visibility for password fields
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }



  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // Validation functions
  void validateName(String value) {
    nameError.value = value.isEmpty ? LocaleKeys.name_required.trans() : '';
  }

  void validateMail(String value) {
    if (value.isEmpty) {
      mailError.value = LocaleKeys.email_required.trans();
    } else if (!GetUtils.isEmail(value)) {
      mailError.value = LocaleKeys.mail_invalid.trans();
    } else {
      mailError.value = '';
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = LocaleKeys.password_required.trans();
    } else if (value.length < 6) {
      passwordError.value = LocaleKeys.password_length.trans();
    } else {
      passwordError.value = '';
    }
  }

  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmPasswordError.value = LocaleKeys.confirm_password_required.trans();
    } else if (value != passwordController.text) {
      confirmPasswordError.value = LocaleKeys.password_mismatch.trans();
    } else {
      confirmPasswordError.value = '';
    }
  }

  // Method to validate all fields at once
  bool validateForm() {
    validateName(nameController.text);
    validateMail(mailController.text);
    validatePassword(passwordController.text);
    validateConfirmPassword(confirmPasswordController.text);

    return nameError.value.isEmpty &&
        mailError.value.isEmpty &&
        passwordError.value.isEmpty &&
        confirmPasswordError.value.isEmpty;
  }

  // Example register action
  Future<void> register() async {
    if (!validateForm()) return;
    // if (!isTermsAccepted.value) {
    //   Get.snackbar(
    //     'Thông báo',
    //     'Bạn cần đồng ý với điều khoản và chính sách bảo mật.',
    //     backgroundColor: Colors.redAccent,
    //     colorText: Colors.white,
    //   );
    //   return;
    // }

    isLoading.value = true;
    try {
      final user = await apiService.register(
        name: nameController.text.trim(),
        email: mailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (user != null) {
        Get.back();
        Get.snackbar(
          'Thành công',
          'Đăng ký thành công!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // TODO: Navigate hoặc lưu user token
      } else {
        Get.snackbar(
          'Thất bại',
          'Đăng ký không thành công.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    nameController.clear();
    mailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    nameError.value = '';
    mailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    //isTermsAccepted.value = false;
  }


  @override
  void onClose() {
    nameController.dispose();
    mailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
