import 'package:fido_box_demo01/modules/user_identification/views/success_verification_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class IdentityConfirmationView extends StatelessWidget {
  const IdentityConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          'Xác thực thông tin',
          style: AppTypography.s20.bold.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Vui lòng kiểm tra thông tin của bạn chính xác',
              style: AppTypography.s14.regular.withColor(AppColors.neutral04),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _buildInput('Họ và tên', 'HUỲNH MAI AN PHÚ'),
            SizedBox(height: 8),
            _buildInput('Ngày tháng năm sinh', '22/10/2002'),
            SizedBox(height: 8),
            _buildInput('Số CCCD', '123456789101'),
            SizedBox(height: 8),
            _buildInput('Nghề nghiệp', 'Giám đốc'),
            SizedBox(height: 8),
            _buildInput('Quốc tịch', 'Việt Nam'),
            SizedBox(height: 8),
            _buildInput(
              'Nơi cấp',
              'Cục Cảnh sát Quản lý hành chính & Trật tự xã hội',
            ),
            SizedBox(height: 8),
            _buildInput('Ngày nhận', '22/10/2022'),
            SizedBox(height: 8),
            _buildInput('Ngày cấp', '23/10/2022'),
            SizedBox(height: 8),
            _buildInput(
              'Địa chỉ thường trú',
              '19 Tân Cảng, phường Thạnh Mỹ Tây, TP.Hồ Chí Minh',
            ),
            const SizedBox(height: 24),
          ],
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
              Get.to(SuccessVerificationView());
            },
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Text('Xác nhận', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        style: AppTypography.s14.regular.withColor(AppColors.neutral01),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTypography.s14.medium,
          filled: true,
          fillColor: AppColors.neutral07,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }
}
