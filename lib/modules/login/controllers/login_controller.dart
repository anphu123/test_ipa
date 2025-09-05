import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';
import '../../../services/otp_service.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class LoginController extends GetxController {
  final GetStorage _storage = GetStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final RxBool isPhoneInvalid = false.obs;
  final RxBool isOtpInvalid = false.obs;
  final RxString phoneError = ''.obs;
  final RxString otpError = ''.obs;

  // Controllers
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  // States
  final RxString phoneCode = ''.obs; // Ví dụ: 84
  final RxInt resendSeconds = 0.obs;
  final RxBool isSendingOtp = false.obs;
  final RxBool isLoading = false.obs;

  // Language state
  final RxString currentLanguage = ''.obs;
  Timer? _timer;

  // comfirm
  final RxBool isTermsAccepted = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('LoginController: onInit called');
    //   _listenForOtp();
    currentLanguage.value = _storage.read('language') ?? 'en';
    print('LoginController: current language set to: ${currentLanguage.value}');
    _checkLoginValidity();
  }

  @override
  void onClose() {
    print('LoginController: onClose called');
    SmsAutoFill().unregisterListener();
    otpController.dispose();
    phoneController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  void updateLanguage(String langCode) {
    print('LoginController: updating language from ${currentLanguage.value} to $langCode');
    currentLanguage.value = langCode;
    _storage.write('language', langCode);
    print('LoginController: language saved to storage');
  }

  void setPhoneCode(String code) {
    print('LoginController: setting phone code to: $code');
    phoneCode.value = code;
  }

  /// Gửi OTP qua API
  Future<void> sendOtp() async {
    print('LoginController: sendOtp started');
    final rawPhone = phoneController.text.trim();
    print('LoginController: raw phone input: $rawPhone');

    // Reset lỗi
    phoneError.value = '';
    otpError.value = '';

    // Validate
    final phoneRegex = RegExp(r'^[0-9]{9,10}$');
    if (rawPhone.isEmpty) {
      print('LoginController: phone is empty');
      phoneError.value = LocaleKeys.enter_phone.trans();
      return;
    } else if (!phoneRegex.hasMatch(rawPhone)) {
      print('LoginController: phone format invalid');
      phoneError.value = LocaleKeys.invalid_phone_format.trans();
      return;
    }

    final cleanedPhone = rawPhone.startsWith('0') ? rawPhone.substring(1) : rawPhone;
    final fullPhone = '${phoneCode.value}$cleanedPhone';
    print('LoginController: cleaned phone: $cleanedPhone, full phone: $fullPhone');

    try {
      isSendingOtp.value = true;
      print('LoginController: sending OTP request to API');

      final response = await ApiLoginService.sendOtp(fullPhone);
      print('LoginController: OTP response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        print('LoginController: OTP sent successfully, starting countdown');
        startCountdown();
      } else {
        print('LoginController: OTP send failed with status: ${response.statusCode}');
        otpError.value = 'Không thể gửi OTP';
      }
    } catch (e) {
      print('LoginController: error sending OTP: $e');
      otpError.value = 'Lỗi khi gửi OTP';
    } finally {
      isSendingOtp.value = false;
      print('LoginController: sendOtp completed');
    }
  }

  Future<void> loginWithOtp() async {
    print('LoginController: loginWithOtp started');
    final rawPhone = phoneController.text.trim();
    final otp = otpController.text.trim();
    print('LoginController: phone: $rawPhone, otp: $otp');

    // Reset lỗi
    phoneError.value = '';
    otpError.value = '';

    bool hasError = false;
    final phoneRegex = RegExp(r'^[0-9]{9,10}$');

    // ✅ Kiểm tra số điện thoại
    if (rawPhone.isEmpty) {
      print('LoginController: phone validation failed - empty');
      phoneError.value = LocaleKeys.enter_phone.trans();
      hasError = true;
    } else if (!phoneRegex.hasMatch(rawPhone)) {
      print('LoginController: phone validation failed - invalid format');
      phoneError.value = LocaleKeys.invalid_phone_format.trans();
      hasError = true;
    }

    // ✅ Kiểm tra OTP
    if (otp.isEmpty) {
      print('LoginController: OTP validation failed - empty');
      otpError.value = LocaleKeys.enter_otp.trans();
      hasError = true;
    } else if (otp.length < 4) {
      print('LoginController: OTP validation failed - too short');
      otpError.value = LocaleKeys.invalid_otp.trans();
      hasError = true;
    }

    if (hasError) {
      print('LoginController: validation errors found, stopping login');
      return;
    }

    if (!isTermsAccepted.value) {
      print('LoginController: terms not accepted, showing confirmation dialog');
      showTermsConfirmationDialog(
        onAgree: () {
          loginWithOtp();
        },
      );
      return;
    }

    final cleanedPhone = rawPhone.startsWith('0') ? rawPhone.substring(1) : rawPhone;
    final fullPhone = '+${phoneCode.value}$cleanedPhone';
    print('LoginController: proceeding with login - full phone: $fullPhone');

    isLoading.value = true;

    try {
      print('LoginController: calling API to verify OTP');
      final response = await ApiLoginService.verifyOtp(fullPhone, otp);
      print('LoginController: verify OTP response status: ${response.statusCode}');

      final data = response.data['data'];
      print('LoginController: response data: $data');

      if (response.statusCode == 200 && data != null && data['success'] == true) {
        final token = data['token'];
        final refreshToken = data['refreshToken'];
        final userPhone = data['phone'] ?? fullPhone;

        print('LoginController: login successful');
        print('LoginController: token: ${token?.substring(0, 20)}...');
        print('LoginController: refreshToken: ${refreshToken?.substring(0, 20)}...');
        print('LoginController: userPhone: $userPhone');

        // ✅ Lưu vào GetStorage
        _storage.write('token', token);
        _storage.write('refreshToken', refreshToken);
        _storage.write('user', {'phone': userPhone});
        _storage.write('isLoggedIn', true);
        _storage.write('loginTime', DateTime.now().toIso8601String());
        print('LoginController: user data saved to storage');

        // ✅ Cập nhật trạng thái đăng nhập
        try {
          final dashboardController = Get.find<DashBoardController>();
          dashboardController.isLoggedIn.value = true;
          print('LoginController: dashboard controller updated');
        } catch (e) {
          print('LoginController: error updating dashboard controller: $e');
        }

        // ✅ Chuyển sang dashboard
        print('LoginController: navigating to dashboard');
        Get.offAllNamed(Routes.dashboard);
      } else {
        print('LoginController: login failed - invalid response');
        otpError.value = data?['message'] ?? LocaleKeys.invalid_otp.trans();
      }
    } catch (e) {
      print('LoginController: error during OTP verification: $e');
      otpError.value = "LocaleKeys.otp_verify_failed.trans()";
    } finally {
      isLoading.value = false;
      print('LoginController: loginWithOtp completed');
    }
  }

  /// Đăng nhập bằng Google
  Future<void> loginWithGoogle() async {
    print('LoginController: loginWithGoogle started');
    isLoading.value = true;

    try {
      print('LoginController: signing out from previous Google session');
      await _googleSignIn.signOut();

      print('LoginController: initiating Google sign in');
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('LoginController: Google sign in cancelled by user');
        Get.snackbar(
          "❌",
          "Bạn chưa chọn tài khoản.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      print('LoginController: Google user selected: ${googleUser.email}');
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('LoginController: signing in with Firebase credential');
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        print('LoginController: Firebase sign in failed - no user');
        Get.snackbar(
          "❌",
          "Đăng nhập thất bại.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      print('LoginController: Firebase user: ${user.uid}, email: ${user.email}');
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      print('LoginController: is new user: $isNewUser');
      
      if (isNewUser) {
        print('LoginController: creating new user in backend');
        await _createNewUserInBackend(user);
      }

      print('LoginController: saving Google login data to storage');
      _storage.write('isLoggedIn', true);
      _storage.write('user', {
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
      });
      _storage.write('loginTime', DateTime.now().toIso8601String());

      print('LoginController: navigating to loading screen');
      Get.offNamed(Routes.loading);
      Get.snackbar(
        "✅",
        "Đăng nhập thành công!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('LoginController: Google sign in error: $e');
      Get.snackbar(
        "❌",
        "Lỗi Google Sign-In: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      print('LoginController: loginWithGoogle completed');
    }
  }

  void startCountdown() {
    print('LoginController: starting countdown timer');
    resendSeconds.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value == 0) {
        print('LoginController: countdown completed');
        timer.cancel();
      } else {
        resendSeconds.value--;
      }
    });
  }

  /// Kiểm tra phiên đăng nhập đã hết hạn chưa (sau 24 giờ)
  void _checkLoginValidity() {
    print('LoginController: checking login validity');
    final isLoggedIn = _storage.read('isLoggedIn') ?? false;
    print('LoginController: current login status: $isLoggedIn');
    
    if (isLoggedIn) {
      final loginTimeStr = _storage.read('loginTime');
      print('LoginController: login time from storage: $loginTimeStr');
      
      final loginTime = DateTime.tryParse(loginTimeStr ?? '');
      if (loginTime != null) {
        final hoursDiff = DateTime.now().difference(loginTime).inHours;
        print('LoginController: hours since login: $hoursDiff');
        
        if (hoursDiff >= 8760) {
          print('LoginController: login expired, clearing data and redirecting');
          _storage.remove('isLoggedIn');
          _storage.remove('user');
          _storage.remove('loginTime');
          Get.offAllNamed(Routes.login);
        } else {
          print('LoginController: login still valid');
        }
      } else {
        print('LoginController: invalid login time format');
      }
    }
  }

  /// Tạo user mới trên backend nếu cần
  Future<void> _createNewUserInBackend(User user) async {
    print('LoginController: creating new user in backend for: ${user.uid}');
    // Gửi thông tin người dùng lên server nếu cần
    // Ví dụ: gọi API tạo mới user
  }

  void showTermsConfirmationDialog({required VoidCallback onAgree}) {
    print('LoginController: showing terms confirmation dialog');
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tiêu đề
              Text(
                'THÔNG BÁO',
                style: AppTypography.s20.bold.withColor(AppColors.neutral01),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Nội dung
              RichText(
                               textAlign: TextAlign.center,
                text: TextSpan(
                  text: LocaleKeys.have_read.trans() + ' ',
                  style: AppTypography.s12.regular.withColor(
                    AppColors.neutral01,
                  ),
                  children: [
                    TextSpan(
                      text: LocaleKeys.terms.trans(),
                      style: AppTypography.s12.regular.withColor(
                        AppColors.AB01,
                      ),
                    ),
                    const TextSpan(text: ', '),
                    TextSpan(
                      text: LocaleKeys.privacy_policy.trans(),
                      style: AppTypography.s12.regular.withColor(
                        AppColors.AB01,
                      ),
                    ),
                    TextSpan(text: ' ${LocaleKeys.and.trans()} '),
                    TextSpan(
                      text: 'Chia sẻ dữ liệu với bên thứ ba',
                      style: AppTypography.s12.regular.withColor(
                        AppColors.AB01,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Nút
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        print('LoginController: terms dialog cancelled');
                        Get.back();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.neutral01),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Hủy',
                        style: AppTypography.s16.regular.withColor(
                          AppColors.neutral01,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('LoginController: terms accepted by user');
                        Get.back(); // Đóng dialog
                        isTermsAccepted.value = true;
                        print('LoginController: terms acceptance saved, proceeding with login');
                        onAgree(); // Thực hiện logic tiếp theo
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary01,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Đồng ý',
                        style: AppTypography.s16.regular.withColor(
                          AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}