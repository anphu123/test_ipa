import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class FormHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;
  final bool isClose;
  final bool isBackButton;

  const FormHeader({
    Key? key,
    required this.title,
    this.isBackButton = false,
    this.onClose,
    this.isClose = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
  //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
           isBackButton ? IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.neutral01),
          onPressed: () => Get.back(),
        ) : SizedBox.shrink(),
        Expanded(
          child: Text(
            title,
            style: AppTypography.s18.bold.withColor(AppColors.neutral01),
            textAlign: TextAlign.center,
          ),
        ),
        isClose ? IconButton(
          onPressed: onClose ?? () => Get.back(),
          icon: Icon(Icons.close, color: AppColors.neutral03),
        ) : SizedBox.shrink(),
        // IconButton(
        //   onPressed: onClose ?? () => Get.back(),
        //   icon: Icon(Icons.close, color: AppColors.neutral03),
        // ),
      ],
    );
  }
}