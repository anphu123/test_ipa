import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/assets/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../controllers/order_purchase_at_store_controller.dart';
import '../../../list_store/domain/store_model.dart';

class StaffInfoWidget extends GetView<OrderPurchaseAtStoreController> {
  const StaffInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Chuyên gia thu mua đã sẵn sàng, đang đợi bạn đến cửa hàng.',
            style: AppTypography.s14.regular.withColor(AppColors.neutral01),
          ),
          SizedBox(height: 12.h),
          Text(
            'Nếu có bất kỳ vấn đề gì, xin vui lòng liên hệ bất cứ lúc nào.',
            style: AppTypography.s12.regular.withColor(AppColors.neutral03),
          ),
          SizedBox(height: 24.h),

          // Staff info (Avatar and Name on same row)
          _buildStaffInfoRow(),
          SizedBox(height: 16.h),



          // Action buttons
          _buildActionButtons(),
          SizedBox(height: 24.h),

          // Appointment info
          _buildAppointmentInfo(),
          SizedBox(height: 24.h),

          // Store info
          _buildStoreInfo(),
        ],
      ),
    );
  }

  Widget _buildStaffInfoRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar
        CircleAvatar(
          radius: 24.r,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Image.asset(
              Assets.images.avaShipper.path,
              fit: BoxFit.cover,
              width: 48.w,
              height: 48.h,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        // Name and position
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    _getStaffName(),
                    style: AppTypography.s14.regular.withColor(AppColors.neutral01),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    width: 1.w,
                    height: 16.h,
                    color: AppColors.neutral06,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Chuyên gia thu mua',
                    style: AppTypography.s14.regular.withColor(AppColors.neutral03),
                  ),
                ],
              ),
              // Stats row
              _buildStatsRow(),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Text(
          'Đã hoàn thành ${_getCompletedOrders()} đơn',
          style: AppTypography.s10.regular.withColor(AppColors.neutral03),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 1.w,
          height: 10.h,
          color: AppColors.neutral06,
        ),
        SizedBox(width: 12.w),
        Text(
          'Tỷ lệ đánh giá tốt ${_getRating()}%',
          style: AppTypography.s10.regular.withColor(AppColors.neutral03),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Assets.images.icTinhieubatthuong.path,
            text: 'Gọi điện',
            onTap: _onCallStaff,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _ActionButton(
            icon: Assets.images.icTinnhan.path,
            text: 'Nhắn tin',
            onTap: _onMessageStaff,
            iconColor: AppColors.neutral01,
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentInfo() {
    return Column(
      children: [
        _InfoRow(
          icon: Icons.access_time,
          label: 'Thời gian hẹn',
          value: _getAppointmentTime(),
        ),
        SizedBox(height: 16.h),
        _InfoRow(
          icon: Icons.phone_outlined,
          label: 'Số điện thoại',
          value: _getCustomerPhoneNumber(),
        ),
        SizedBox(height: 16.h),
        _ActionButton(
          text: 'Thay đổi địa chỉ/thời gian',
          textStyle: AppTypography.s14.medium.withColor(AppColors.neutral02),
          onTap: _onChangeAppointment,
          isFullWidth: true,
        ),
      ],
    );
  }

  String _getStaffName() {
    return controller.orderData['staffName']?.toString() ??
        controller.currentStaff.value?.name ??
        'Alice';
  }

  String _getCompletedOrders() {
    return controller.orderData['staffCompletedOrders']?.toString() ??
        controller.currentStaff.value?.completedOrders?.toString() ??
        '16493';
  }

  String _getRating() {
    return controller.orderData['staffRating']?.toString() ??
        controller.currentStaff.value?.rating?.toString() ??
        '98';
  }

  String _getAppointmentTime() {
    return controller.orderData['appointmentTime']?.toString() ??
        controller.appointmentTime ??
        _getDefaultAppointmentTime();
  }

  String _getCustomerPhoneNumber() {
    return controller.orderData['phoneNumber']?.toString() ??
        controller.orderData['contactPhone']?.toString() ??
        controller.customerPhoneNumber ??
        '0123456789';
  }

  String _getDefaultAppointmentTime() {
    final now = DateTime.now();
    final appointmentTime = now.add(const Duration(hours: 2));
    final endTime = appointmentTime.add(const Duration(hours: 1));
    return '${appointmentTime.day.toString().padLeft(2, '0')}/${appointmentTime.month.toString().padLeft(2, '0')}/${appointmentTime.year} '
        '${appointmentTime.hour.toString().padLeft(2, '0')}:${appointmentTime.minute.toString().padLeft(2, '0')}-'
        '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
  }

  void _onCallStaff() {
    controller.callStaff();
  }

  void _onMessageStaff() {
    controller.messageStaff();
  }

  void _onChangeAppointment() {
    Get.snackbar(
      'Thông báo',
      'Chức năng thay đổi lịch hẹn đang được phát triển',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary01,
      colorText: AppColors.white,
    );
  }

  // Store info getter methods - Priority: StoreModel -> orderData -> defaults
  String _getStoreName() {
    final store = controller.currentStore.value;
    if (store != null) {
      return store.name;
    }
    return controller.orderData['storeName'] ?? 'Cửa hàng 2Hand';
  }

  String _getStoreDistance() {
    final store = controller.currentStore.value;
    String distance = '0';

    if (store != null) {
      distance = store.distance;
    } else {
      distance = controller.orderData['storeDistance'] ?? '0';
    }

    return 'Cách bạn ${distance}km';
  }

  String _getStoreImageUrl() {
    final store = controller.currentStore.value;
    if (store != null) {
      return store.imageUrl;
    }
    return controller.orderData['storeImageUrl'] ??
           'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400';
  }

  String _getStoreAddress() {
    final store = controller.currentStore.value;
    if (store != null) {
      // Generate full address from StoreModel
      return '${store.name}, ${store.district}';
    }
    return controller.orderData['storeAddress'] ??
           '19 Tân Cảng, phường 25, quận Bình Thạnh, TP. Hồ Chí Minh';
  }

  String _getStoreOpenHours() {
    final store = controller.currentStore.value;
    if (store != null) {
      return store.openHours;
    }
    return controller.orderData['storeOpenHours'] ?? '10:00 - 22:00';
  }

  void _onCopyStoreAddress() {
    // Copy store address to clipboard
    Get.snackbar(
      'Đã sao chép',
      'Địa chỉ cửa hàng đã được sao chép',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary01,
      colorText: AppColors.white,
    );
  }

  void _onNavigateToStore() {
    // Navigate to store using coordinates from StoreModel
    final store = controller.currentStore.value;

    if (store != null) {
      // Log tọa độ cửa hàng
      print('🗺️ Navigating to store coordinates:');
      print('📍 Store: ${store.name}');
      print('📍 Latitude: ${store.latitude}');
      print('📍 Longitude: ${store.longitude}');
      print('📍 District: ${store.district}');
      print('📍 Distance: ${store.distance} km');

      // Gửi tọa độ trực tiếp đến Google Maps
      controller.navigateToStore();

      // Hiển thị thông báo với tọa độ
      Get.snackbar(
        'Đang chỉ đường',
        'Tọa độ: ${store.latitude.toStringAsFixed(6)}, ${store.longitude.toStringAsFixed(6)}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primary01,
        colorText: AppColors.white,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.directions, color: AppColors.white),
      );
    } else {
      // Fallback nếu không có dữ liệu cửa hàng
      print('❌ No store data available for navigation');
      Get.snackbar(
        'Lỗi',
        'Không tìm thấy tọa độ cửa hàng để chỉ đường',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.AE01,
        colorText: AppColors.white,
      );
    }
  }

  Widget _buildStoreInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.neutral07,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                //_getStoreName(),
                "Cửa hàng 2Hand",
                style: AppTypography.s16.medium.withColor(AppColors.neutral01),
              ),
              Row(
                children: [
                  Text(
                    _getStoreDistance(),
                    style: AppTypography.s14.regular.withColor(AppColors.neutral04),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.chevron_right,
                    size: 16.r,
                    color: AppColors.neutral04,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Store details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store image
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                    image: NetworkImage(_getStoreImageUrl()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Store info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStoreAddress(),
                      style: AppTypography.s14.regular.withColor(AppColors.neutral01),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Giờ mở cửa: ${_getStoreOpenHours()}',
                      style: AppTypography.s14.regular.withColor(AppColors.neutral04),
                    ),
                  ],
                ),
              ),

              // Action buttons
              Column(
                children: [
                  // Copy icon
                  GestureDetector(
                    onTap: _onCopyStoreAddress,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.neutral04,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.copy_outlined,
                          size: 12.r,
                          color: AppColors.neutral03,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Direction button
                  GestureDetector(
                    onTap: _onNavigateToStore,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary01,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.directions,
                          size: 12.r,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String? icon;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool isFullWidth;

  const _ActionButton({
    this.icon,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.iconColor,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      height: 44.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral05),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Image.asset(
                  icon!,
                  color: iconColor,
                  width: 20.w,
                  height: 20.h,
                ),
                SizedBox(width: 8.w),
              ],
              Text(
                text,
                style: textStyle ?? AppTypography.s10.medium.withColor(AppColors.neutral01),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.r, color: AppColors.neutral04),
        SizedBox(width: 12.w),
        Text(
          label,
          style: AppTypography.s14.regular.withColor(AppColors.neutral03),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            value,
            style: AppTypography.s14.medium.withColor(AppColors.neutral01),
          ),
        ),
      ],
    );
  }

}
