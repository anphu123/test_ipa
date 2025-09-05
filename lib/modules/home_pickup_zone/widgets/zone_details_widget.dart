import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/pickup_zone_model.dart';

/// Widget hiển thị thông tin chi tiết của pickup zone trong bottom sheet
class ZoneDetailsWidget extends StatelessWidget {
  final PickupZoneModel zone;
  final VoidCallback? onBookPickup;
  final VoidCallback? onViewRules;

  const ZoneDetailsWidget({
    super.key,
    required this.zone,
    this.onBookPickup,
    this.onViewRules,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          SizedBox(height: 16),
          _buildZoneDetails(),
          SizedBox(height: 20),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Khu vực thu mua tại nhà',
          style: AppTypography.s16.bold,
        ),
        SizedBox(height: 8),
        Text(
          zone.name,
          style: AppTypography.s14.medium.copyWith(
            color: AppColors.primary01,
          ),
        ),
      ],
    );
  }

  Widget _buildZoneDetails() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.neutral08,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutral06),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
            icon: Icons.location_on,
            title: 'Khu vực',
            content: zone.name,
          ),
          SizedBox(height: 8),
          _buildDetailRow(
            icon: Icons.description,
            title: 'Mô tả',
            content: zone.description,
          ),
          SizedBox(height: 8),
          _buildDetailRow(
            icon: Icons.access_time,
            title: 'Thời gian hoạt động',
            content: _getOperatingHours(),
          ),
          SizedBox(height: 8),
          _buildDetailRow(
            icon: Icons.info,
            title: 'Trạng thái',
            content: zone.isActive ? 'Đang hoạt động' : 'Tạm ngưng',
            contentColor: zone.isActive ? AppColors.success : AppColors.error,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String content,
    Color? contentColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.primary01,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.s12.medium.copyWith(
                  color: AppColors.neutral02,
                ),
              ),
              SizedBox(height: 2),
              Text(
                content,
                style: AppTypography.s12.regular.copyWith(
                  color: contentColor ?? AppColors.neutral01,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Button xem quy tắc
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onViewRules ?? () => Get.back(),
            icon: Icon(Icons.rule, size: 16),
            label: Text('Xem quy tắc'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary01,
              side: BorderSide(color: AppColors.primary01),
            ),
          ),
        ),
        SizedBox(width: 12),
        // Button đặt lịch
        Expanded(
          child: ElevatedButton.icon(
            onPressed: zone.isActive ? (onBookPickup ?? () => Get.back()) : null,
            icon: Icon(Icons.schedule, size: 16),
            label: Text('Đặt lịch'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary01,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.neutral04,
            ),
          ),
        ),
      ],
    );
  }

  String _getOperatingHours() {
    // Có thể customize theo dữ liệu thực tế của zone
    return '8:00 - 18:00 (Thứ 2 - Thứ 6)';
  }
}

/// Widget hiển thị thông tin zone đơn giản trong danh sách
class ZoneListItemWidget extends StatelessWidget {
  final PickupZoneModel zone;
  final VoidCallback? onTap;

  const ZoneListItemWidget({
    super.key,
    required this.zone,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.neutral06),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 40,
              decoration: BoxDecoration(
                color: zone.isActive ? AppColors.success : AppColors.error,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    zone.name,
                    style: AppTypography.s14.medium,
                  ),
                  SizedBox(height: 4),
                  Text(
                    zone.description,
                    style: AppTypography.s12.regular.copyWith(
                      color: AppColors.neutral02,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.neutral04,
            ),
          ],
        ),
      ),
    );
  }
}
