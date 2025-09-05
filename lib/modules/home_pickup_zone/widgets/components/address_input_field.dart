import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AddressInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String placeholder;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool isRequired;
  final bool showValidation;
  final String? helperText;
  final Widget? suffixIcon;
  final bool isValidating;
  final String? validationMessage;
  final String? Function(String?)? validator;

  const AddressInputField({
    Key? key,
    required this.label,
    required this.controller,
    required this.placeholder,
    this.keyboardType,
    this.maxLines = 1,
    this.isRequired = false,
    this.showValidation = false,
    this.helperText,
    this.suffixIcon,
    this.isValidating = false,
    this.validationMessage,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(),
        SizedBox(height: 8.h),
        _buildTextField(),
        if (showValidation && validationMessage != null) ...[
          SizedBox(height: 4.h),
          _buildValidationMessage(),
        ],
      ],
    );
  }

  Widget _buildLabel() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: AppTypography.s14.medium.withColor(AppColors.neutral01),
          ),
          if (isRequired)
            TextSpan(
              text: ' *',
              style: AppTypography.s14.medium.withColor(Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: AppTypography.s14.regular.withColor(AppColors.neutral03),
        helperText: helperText,
        helperStyle: AppTypography.s12.regular.withColor(AppColors.neutral04),
        border: _buildBorder(AppColors.neutral04),
        enabledBorder: _buildBorder(AppColors.neutral04),
        focusedBorder: _buildBorder(AppColors.primary01),
        errorBorder: _buildBorder(Colors.red),
        focusedErrorBorder: _buildBorder(Colors.red),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        suffixIcon: _buildSuffixIcon(),
      ),
      validator: validator,
    );
  }

  Widget? _buildSuffixIcon() {
    if (showValidation && isValidating) {
      return SizedBox(
        width: 20.w,
        height: 20.h,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary01,
          ),
        ),
      );
    }

    return null;
  }

  Widget _buildValidationMessage() {
    final isSuccess = validationMessage!.contains('✅') || validationMessage!.contains('có hỗ trợ');
    final isWarning = validationMessage!.contains('⚠️');

    Color iconColor = Colors.red;
    IconData iconData = Icons.error;

    if (isSuccess) {
      iconColor = Colors.green;
      iconData = Icons.check_circle;
    } else if (isWarning) {
      iconColor = Colors.orange;
      iconData = Icons.warning;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(iconData, size: 16.sp, color: iconColor),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            validationMessage!,
            style: AppTypography.s12.regular.withColor(iconColor),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: color),
    );
  }
}