import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/order_purchase_at_store_controller.dart';
import 'widgets/store_info_widget.dart';
import 'widgets/order_bottom_sheet.dart';
import 'widgets/bottom_button_widget.dart';

class OrderPurchaseAtStoreView extends GetView<OrderPurchaseAtStoreController> {
  const OrderPurchaseAtStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Full screen map (without overlays) - similar to OrderPurchaseAtHomeView
          StoreInfoWidget(),

          // Bottom sheet with content - starts at 50% of screen height
          DraggableScrollableSheet(
              initialChildSize: 0.5, // 50% of screen initially
              minChildSize: 0.3, // Minimum 30% of screen
              maxChildSize: 0.9, // Maximum 90% of screen
              snap: true,
            builder: (context, scrollController) {
              return OrderBottomSheet(scrollController: scrollController);
            },
          ),
        ],
      ),

      // Bottom button - same as at_home
      bottomNavigationBar: const BottomButtonWidget(),

      // Floating action button for order status simulation
      floatingActionButton: _buildOrderStatusFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget _buildOrderStatusFAB() {
    return Obx(() {
      final status = controller.orderStatus.value;
      final statusConfig = _getStatusConfig(status);

      return Container(
        margin: EdgeInsets.only(top: 80.h), // Position below status bar
        child: FloatingActionButton.extended(
          onPressed: _onStatusFABPressed,
          backgroundColor: statusConfig['color'],
          foregroundColor: AppColors.white,
          icon: Icon(statusConfig['icon'], size: 20.r),
          label: Text(
            statusConfig['label'],
            style: AppTypography.s12.medium.withColor(AppColors.white),
          ),
        ),
      );
    });
  }

  Map<String, dynamic> _getStatusConfig(String status) {
    switch (status) {
      case 'waiting_confirmation':
        return {
          'label': 'Chờ xác nhận',
          'icon': Icons.hourglass_empty,
          'color': AppColors.AW01,
        };
      case 'confirmed':
        return {
          'label': 'Đã xác nhận',
          'icon': Icons.check_circle,
          'color': AppColors.AS01, // Success color
        };
      case 'ready_for_pickup':
        return {
          'label': 'Sẵn sàng lấy',
          'icon': Icons.store,
          'color': AppColors.primary01,
        };
      case 'completed':
        return {
          'label': 'Hoàn thành',
          'icon': Icons.done_all,
          'color': AppColors.AS01, // Success color
        };
      case 'cancelled':
        return {
          'label': 'Đã hủy',
          'icon': Icons.cancel,
          'color': AppColors.AE01, // Error color
        };
      default:
        return {
          'label': 'Không xác định',
          'icon': Icons.help,
          'color': AppColors.neutral04,
        };
    }
  }

  void _onStatusFABPressed() {
    _showOrderStatusDialog();
  }

  void _showOrderStatusDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Giả lập trạng thái đơn hàng',
          style: AppTypography.s16.medium.withColor(AppColors.neutral01),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chọn trạng thái mới cho đơn hàng:',
              style: AppTypography.s14.regular.withColor(AppColors.neutral03),
            ),
            SizedBox(height: 16.h),
            _buildStatusOption('waiting_confirmation', 'Chờ xác nhận', Icons.hourglass_empty, AppColors.AW01),
            _buildStatusOption('confirmed', 'Đã xác nhận', Icons.check_circle, AppColors.AS01),
            _buildStatusOption('ready_for_pickup', 'Sẵn sàng lấy hàng', Icons.store, AppColors.primary01),
            _buildStatusOption('completed', 'Hoàn thành', Icons.done_all, AppColors.AS01),
            _buildStatusOption('cancelled', 'Đã hủy', Icons.cancel, AppColors.AE01),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Đóng',
              style: AppTypography.s14.medium.withColor(AppColors.neutral03),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOption(String status, String label, IconData icon, Color color) {
    return Obx(() {
      final isSelected = controller.orderStatus.value == status;

      return Container(
        margin: EdgeInsets.only(bottom: 8.h),
        child: InkWell(
          onTap: () {
            controller.updateOrderStatus(status);
            Get.back();
            _showStatusChangeSnackbar(label);
          },
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected ? color : AppColors.neutral06,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20.r,
                  color: isSelected ? color : AppColors.neutral04,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.s14.regular.withColor(
                      isSelected ? color : AppColors.neutral01,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check,
                    size: 16.r,
                    color: color,
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _showStatusChangeSnackbar(String statusLabel) {
    Get.snackbar(
      'Trạng thái đã thay đổi',
      'Đơn hàng chuyển sang: $statusLabel',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary01,
      colorText: AppColors.white,
      duration: Duration(seconds: 2),
      icon: Icon(Icons.info, color: AppColors.white),
    );
  }

  // Widget _buildStoreSection() {
  //   return GetBuilder<OrderPurchaseAtStoreController>(
  //     builder: (controller) {
  //       // Always show fallback UI for release build stability
  //       // Map will be handled inside StoreInfoWidget with proper error handling
  //       return StoreInfoWidget();
  //     },
  //   );
  // }

  // Widget _buildFallbackStoreUI() {
  //   return Container(
  //     height: MediaQuery.of(Get.context!).size.height * 0.5,
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         colors: [AppColors.primary01, AppColors.primary01.withOpacity(0.8)],
  //       ),
  //     ),
  //     child: SafeArea(
  //       child: Padding(
  //         padding: EdgeInsets.all(16.w),
  //         child: Column(
  //           children: [
  //             // App bar
  //             Row(
  //               children: [
  //                 IconButton(
  //                   onPressed: () => Get.back(),
  //                   icon: Icon(Icons.arrow_back, color: AppColors.white),
  //                 ),
  //                 Expanded(
  //                   child: Text(
  //                     'Thu mua tại cửa hàng',
  //                     style: AppTypography.s16.bold.copyWith(
  //                       color: AppColors.white,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //                 SizedBox(width: 48.w),
  //               ],
  //             ),
  //             SizedBox(height: 32.h),
  //
  //             // Store icon
  //             Container(
  //               width: 120.w,
  //               height: 120.w,
  //               decoration: BoxDecoration(
  //                 color: AppColors.white.withOpacity(0.2),
  //                 borderRadius: BorderRadius.circular(60.r),
  //               ),
  //               child: Icon(Icons.store, size: 60.r, color: AppColors.white),
  //             ),
  //             SizedBox(height: 24.h),
  //
  //             // Store info
  //             GetBuilder<OrderPurchaseAtStoreController>(
  //               builder: (controller) {
  //                 return Column(
  //                   children: [
  //                     Text(
  //                       controller.storeName,
  //                       style: AppTypography.s20.bold.copyWith(
  //                         color: AppColors.white,
  //                       ),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                     SizedBox(height: 8.h),
  //                     Text(
  //                       controller.storeAddress,
  //                       style: AppTypography.s14.regular.copyWith(
  //                         color: AppColors.white.withOpacity(0.9),
  //                       ),
  //                       textAlign: TextAlign.center,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ],
  //                 );
  //               },
  //             ),
  //             SizedBox(height: 24.h),
  //
  //             // Action buttons
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: ElevatedButton.icon(
  //                     onPressed:
  //                         () =>
  //                             Get.find<OrderPurchaseAtStoreController>()
  //                                 .callStore(),
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: AppColors.white,
  //                       foregroundColor: AppColors.primary01,
  //                       padding: EdgeInsets.symmetric(vertical: 12.h),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8.r),
  //                       ),
  //                     ),
  //                     icon: Icon(Icons.phone, size: 20.r),
  //                     label: Text(
  //                       'Gọi cửa hàng',
  //                       style: AppTypography.s14.medium,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(width: 12.w),
  //                 Expanded(
  //                   child: ElevatedButton.icon(
  //                     onPressed:
  //                         () =>
  //                             Get.find<OrderPurchaseAtStoreController>()
  //                                 .navigateToStore(),
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: AppColors.white.withOpacity(0.2),
  //                       foregroundColor: AppColors.white,
  //                       padding: EdgeInsets.symmetric(vertical: 12.h),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8.r),
  //                         side: BorderSide(color: AppColors.white),
  //                       ),
  //                     ),
  //                     icon: Icon(Icons.directions, size: 20.r),
  //                     label: Text('Chỉ đường', style: AppTypography.s14.medium),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
