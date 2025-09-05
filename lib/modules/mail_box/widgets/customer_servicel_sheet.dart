import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/app_page.dart';

class CustomerServiceSheet extends StatefulWidget {
  const CustomerServiceSheet({super.key});

  @override
  State<CustomerServiceSheet> createState() => _CustomerServiceSheetState();
}

class _CustomerServiceSheetState extends State<CustomerServiceSheet> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          _buildDragHandle(),
          _buildHeader(context),
          SizedBox(height: 16.h),
          Expanded(
            child: SingleChildScrollView(
              child:
                  selectedTabIndex == 0 ? _buildOrderTab() : _buildServiceTab(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 40.w,
        height: 4.h,
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTabButton('Dịch vụ', 0),
            SizedBox(width: 16.w),
            _buildTabButton('Đơn hàng', 1),
          ],
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String title, int index) {
    final bool isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          setState(() => selectedTabIndex = index);
        }
      },
      child: Text(
        title,
        style: AppTypography.s18.semibold.copyWith(
          color: isSelected ? AppColors.primary01 : AppColors.neutral03,
        ),
      ),
    );
  }

  Widget _buildServiceTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildServiceSection('Sản phẩm đã kiểm định', [
          _buildServiceItem(
            Assets.images.icEdivince1.path,
            'Thiết bị điện tử',
            AppColors.AB01,
            () {
              Get.toNamed(Routes.supportchat, arguments: 'Thiết bị điện tử');
            },
          ),
        ]),
        SizedBox(height: 20.h),
        _buildServiceSection('Phương thức giao dịch', [
          _buildServiceItem(
            Assets.images.icBoxtick.path,
            'Ký gửi',
            AppColors.primary01,
            () {
              // Get.toNamed('/support_chat', arguments: 'Thiết bị điện tử');
              Get.toNamed(Routes.supportchat, arguments: 'Ký gửi');
            },
          ),
          _buildServiceItem(
            Assets.images.icDeli.path,
            'Vận chuyển\nBưu điện',
            AppColors.AS01,
            () {
              Get.toNamed(Routes.supportchat, arguments: 'Vận chuyển Bưu điện');
            },
          ),
          _buildServiceItem(
            Assets.images.icHome1.path,
            'Vận chuyển\ntại nhà',
            AppColors.AW01,
            () {
              Get.toNamed(Routes.supportchat, arguments: 'Vận chuyển tại nhà');
            },
          ),
        ]),
        SizedBox(height: 20.h),
        _buildServiceSection('Giao dịch tự do', [
          _buildServiceItem(
            Assets.images.icShop1.path,
            'Chợ tự do',
            AppColors.AE01,
            () {
              Get.toNamed(Routes.supportchat, arguments: 'Chợ tự do');
            },
          ),
        ], showDivider: false),
      ],
    );
  }

  Widget _buildOrderTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Đơn hàng gần đây',
          style: AppTypography.s14.medium.withColor(AppColors.neutral03),
        ),
        SizedBox(height: 8.h),
        _buildOrderItem('Đơn #123456', 'Đang xử lý', AppColors.primary01),
        _buildOrderItem('Đơn #654321', 'Đã giao', AppColors.red700),
      ],
    );
  }

  Widget _buildOrderItem(String title, String status, Color statusColor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.s14.regular),
          Text(
            status,
            style: AppTypography.s14.medium.copyWith(color: statusColor),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSection(
    String title,
    List<Widget> items, {
    bool showDivider = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.s14.medium.withColor(AppColors.neutral03),
        ),
        SizedBox(height: 12.h),
        Wrap(spacing: 16.w, runSpacing: 12.h, children: items),
        if (showDivider) ...[SizedBox(height: 12.h), Divider()],
      ],
    );
  }

  Widget _buildServiceItem(
    String imageAsset,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Center(
                child: Image.asset(
                  imageAsset,
                  width: 40.w,
                  height: 40.w,
                 // color: color,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: AppTypography.s12.regular,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
