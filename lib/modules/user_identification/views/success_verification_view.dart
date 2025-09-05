import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';

class SuccessVerificationView extends StatelessWidget {
  const SuccessVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          'Xác minh danh tính',
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Center(
                child: Image.asset(
                  Assets.images.bgXacthucthanhcong.path, // ví dụ: assets/images/success_verification.png
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Xác thực tài khoản thành công',
                style: AppTypography.s18.bold.withColor(AppColors.neutral01),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Tiếp theo bạn hãy thực hiện xác thực khuôn mặt để đảm bảo an toàn cho tài khoản của bạn ở mức độ cao nhất',
                style: AppTypography.s14.regular.withColor(AppColors.neutral04),
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          height: 48,
          //  padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.primary01,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              // Submit hoặc chuyển bước tiếp theo
              Get.offAllNamed(Routes.persionalProfile);
            },
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Text('Xác nhận', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),    );
  }
}
