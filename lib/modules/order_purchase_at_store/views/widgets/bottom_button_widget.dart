import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_store_controller.dart';

class BottomButtonWidget extends GetView<OrderPurchaseAtStoreController> {
  const BottomButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(() {
          final status = controller.orderStatus.value;
          
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Status info
              // if (status == 'waiting_confirmation') ...[
              //   Container(
              //     width: double.infinity,
              //     padding: EdgeInsets.all(12.w),
              //     decoration: BoxDecoration(
              //       color: AppColors.AW01.withOpacity(0.1),
              //       borderRadius: BorderRadius.circular(8.r),
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(
              //           Icons.schedule,
              //           color: AppColors.AW01,
              //           size: 16.r,
              //         ),
              //         SizedBox(width: 8.w),
              //         Expanded(
              //           child: Text(
              //             'Đơn hàng đang chờ xác nhận từ cửa hàng',
              //             style: AppTypography.s12.regular.copyWith(
              //               color: AppColors.AW01,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   SizedBox(height: 12.h),
              // ],
              //
              // if (status == 'ready_for_pickup') ...[
              //   Container(
              //     width: double.infinity,
              //     padding: EdgeInsets.all(12.w),
              //     decoration: BoxDecoration(
              //       color: AppColors.success.withOpacity(0.1),
              //       borderRadius: BorderRadius.circular(8.r),
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(
              //           Icons.check_circle,
              //           color: AppColors.success,
              //           size: 16.r,
              //         ),
              //         SizedBox(width: 8.w),
              //         Expanded(
              //           child: Text(
              //             'Đơn hàng đã sẵn sàng! Bạn có thể đến cửa hàng nhận hàng',
              //             style: AppTypography.s12.regular.copyWith(
              //               color: AppColors.success,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   SizedBox(height: 12.h),
              // ],

              // Main button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _getButtonAction(status),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getButtonColor(status),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: controller.isConfirming.value
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          _getButtonText(status),
                          style: AppTypography.s16.medium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                ),
              ),

              // Secondary button (if needed)
              if (status == 'confirmed' || status == 'preparing') ...[
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => controller.callStore(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      side: BorderSide(color: AppColors.primary01),
                    ),
                    child: Text(
                      'Gọi cửa hàng',
                      style: AppTypography.s14.medium.copyWith(
                        color: AppColors.primary01,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }

  VoidCallback? _getButtonAction(String status) {
    switch (status) {
      case 'waiting_confirmation':
        return null; // Disabled
      case 'confirmed':
      case 'preparing':
        return () => controller.navigateToStore();
      case 'ready_for_pickup':
        return () => controller.navigateToStore();
      case 'completed':
        return () => Get.back();
      default:
        return null;
    }
  }

  Color _getButtonColor(String status) {
    switch (status) {
      case 'waiting_confirmation':
        return AppColors.neutral05;
      case 'completed':
        return AppColors.success;
      default:
        return AppColors.primary01;
    }
  }

  String _getButtonText(String status) {
    switch (status) {
      case 'waiting_confirmation':
        return 'Chờ xác nhận...';
      case 'confirmed':
      case 'preparing':
        return 'Đến cửa hàng';
      case 'ready_for_pickup':
        return 'Đến nhận hàng';
      case 'completed':
        return 'Hoàn thành';
      default:
        return 'Tiếp tục';
    }
  }
}
