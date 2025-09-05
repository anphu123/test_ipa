import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_home_controller.dart';

class RouteProgressWidget extends GetView<OrderPurchaseAtHomeController> {
  const RouteProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final shipperData = controller.shipper.value;
      
      if (shipperData == null || shipperData.status == 'arrived') {
        return const SizedBox.shrink();
      }

      return Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Shipper đang trên đường đến',
                  style: AppTypography.s14.medium.copyWith(
                    color: AppColors.neutral01,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.navigation,
                  color: Colors.blue,
                  size: 16.r,
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Progress bar
            _buildProgressBar(),
            SizedBox(height: 8.h),

            // Distance and time info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getDistanceText(),
                  style: AppTypography.s12.regular.copyWith(
                    color: AppColors.neutral03,
                  ),
                ),
                Text(
                  shipperData.estimatedArrival,
                  style: AppTypography.s12.medium.copyWith(
                    color: AppColors.primary01,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProgressBar() {
    final shipperData = controller.shipper.value;
    if (shipperData == null) return const SizedBox.shrink();

    // Calculate progress based on distance
    final progress = _calculateProgress();

    return Container(
      height: 4.h,
      decoration: BoxDecoration(
        color: AppColors.neutral06,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ),
    );
  }

  double _calculateProgress() {
    final shipperData = controller.shipper.value;
    if (shipperData == null) return 0.0;

    // Get customer location
    final customerLocation = controller.getLocationFromAddress(controller.customerAddress);
    if (customerLocation == null) return 0.0;

    // Calculate distances
    final currentDistance = _calculateDistance(
      shipperData.latitude,
      shipperData.longitude,
      customerLocation.latitude,
      customerLocation.longitude,
    );

    // Original distance (when shipper started)
    const originalDistance = 0.02; // Approximate original distance

    // Calculate progress (1.0 - remaining distance / original distance)
    final progress = 1.0 - (currentDistance / originalDistance);
    return progress.clamp(0.0, 1.0);
  }

  double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    return ((lat2 - lat1) * (lat2 - lat1) + (lng2 - lng1) * (lng2 - lng1));
  }

  String _getDistanceText() {
    final shipperData = controller.shipper.value;
    if (shipperData == null) return '';

    final customerLocation = controller.getLocationFromAddress(controller.customerAddress);
    if (customerLocation == null) return '';

    final distance = _calculateDistance(
      shipperData.latitude,
      shipperData.longitude,
      customerLocation.latitude,
      customerLocation.longitude,
    );

    // Convert to approximate real distance (very rough estimation)
    final distanceKm = distance * 50; // Rough conversion factor
    
    if (distanceKm < 1) {
      return '${(distanceKm * 1000).round()}m còn lại';
    } else {
      return '${distanceKm.toStringAsFixed(1)}km còn lại';
    }
  }
}
