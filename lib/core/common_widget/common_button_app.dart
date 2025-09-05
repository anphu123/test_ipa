import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

class CommonButtonApp extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final bool isDisabled;
  final bool isLoading;
  final Color progressColor;
  final double height;
  final double width;
  final double fontSize;
  final double radius;

  const CommonButtonApp({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.bgColor = AppColors.primary,
    this.textColor = AppColors.white,
    this.borderColor = AppColors.primary,
    this.isDisabled = false,
    this.isLoading = false,
    this.progressColor = AppColors.white,
    this.height = 45,
    this.width = double.maxFinite,
    this.fontSize = 14,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: isDisabled ? AppColors.disable : (isLoading ? borderColor.withOpacity(0.7) : borderColor),
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(radius),
        color: isDisabled ? AppColors.disable : (isLoading ? bgColor.withOpacity(0.7) : bgColor),
        child: InkWell(
          onTap: isDisabled || isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(radius),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: progressColor,
                    ),
                  ).paddingOnly(right: 10.w)
                      : const SizedBox.shrink(),
                  Flexible(
                    child: Text(
                      buttonText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                        color: isDisabled ? AppColors.gray80 : textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
