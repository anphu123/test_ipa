import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ValidationStatusWidget extends StatelessWidget {
  final bool isLoading;
  final String message;
  final bool isSuccess;

  const ValidationStatusWidget({
    Key? key,
    required this.isLoading,
    required this.message,
    this.isSuccess = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: _getBorderColor(),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildIcon(),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              message,
              style: AppTypography.s14.regular.withColor(_getTextColor()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (isLoading) {
      return SizedBox(
        width: 16.w,
        height: 16.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.neutral02,
        ),
      );
    }

    return Icon(
      isSuccess ? Icons.check_circle : Icons.warning,
      color: isSuccess ? AppColors.success : AppColors.red600,
      size: 20.sp,
    );
  }

  Color _getBackgroundColor() {
    if (isLoading) return AppColors.neutral05;
    if (isSuccess) return AppColors.success.withOpacity(0.1);
    return AppColors.red600.withOpacity(0.1);
  }

  Color _getBorderColor() {
    if (isLoading) return AppColors.neutral04;
    if (isSuccess) return AppColors.success;
    return AppColors.red600;
  }

  Color _getTextColor() {
    if (isLoading) return AppColors.neutral02;
    if (isSuccess) return AppColors.success;
    return AppColors.red600;
  }
}