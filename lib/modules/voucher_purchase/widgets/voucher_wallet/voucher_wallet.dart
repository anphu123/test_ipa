import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../router/app_page.dart';
import '../../controllers/voucher_purchase_controller.dart';
import '../../domain/voucher_model.dart';

class VoucherWalletView extends StatelessWidget {
  final VoucherPurchaseController controller = Get.put(VoucherPurchaseController());

  VoucherWalletView({super.key});

  final List<String> tabs = ["Chưa sử dụng", "Đã sử dụng", "Đã hết hạn"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: AppColors.neutral08,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: Text(
            "Ví Voucher",
            style: AppTypography.s16.bold.withColor(AppColors.black),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Get.back(),
          ),
          bottom: TabBar(
            onTap: controller.onTabWalletChanged,
            labelColor: AppColors.primary01,
            unselectedLabelColor: AppColors.neutral03,
            labelStyle: AppTypography.s14.bold,
            indicatorColor: AppColors.primary01,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text(
                "Khi bạn gộp nhiều sản phẩm trong cùng một đơn hàng, mỗi sản phẩm đều có cơ hội nhận được voucher tăng giá. "
                    "Hệ thống sẽ tự động áp dụng voucher có giá trị cao nhất.",
                style: AppTypography.s12.regular.withColor(AppColors.neutral04),
              ),
            ),
            Expanded(
              child: Obx(
                    () => TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildVoucherList(controller.availableVouchers),
                    _buildVoucherList(controller.usedVouchers),
                    _buildVoucherList(controller.expiredVouchers),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherList(List<VoucherModel> vouchers) {
    if (vouchers.isEmpty) {
      return Center(
        child: Text("Không có voucher", style: AppTypography.s14.regular),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      itemCount: vouchers.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (_, i) {
        final voucher = vouchers[i];
        return _buildVoucherItem(voucher);
      },
    );
  }

  Widget _buildVoucherItem(VoucherModel voucher) {
    final bgImage = _getBackgroundImage(voucher.status);
    final buttonColor = _getButtonColor(voucher.status);
    final buttonLabel = _getButtonLabel(voucher.status);
    final centerVoucherImage = _getCenterVoucherImage(voucher.status);

    return Container(
      height: 100.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              bgImage.path,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                Image.asset(
                  centerVoucherImage.path,
                  width: 48.w,
                  height: 48.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 40.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${voucher.amount} đơn từ", style: AppTypography.s14.bold),
                      Text(voucher.condition, style: AppTypography.s13.medium),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text("HSD: ${voucher.expiry}", style: AppTypography.s10.regular),
                          SizedBox(width: 6.w),
                          Text("Điều kiện", style: AppTypography.s10.regular.copyWith(color: Colors.blue)),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: voucher.status == VoucherStatus.available
                      ? () {
                    Get.toNamed(Routes.categoryFidoPurchase, arguments: {'voucher': voucher});
                  }
                      : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                  child: Text(
                    buttonLabel,
                    style: AppTypography.s12.medium.withColor(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helpers to determine style based on voucher status
  AssetGenImage _getBackgroundImage(VoucherStatus status) {
    switch (status) {
      case VoucherStatus.available:
        return Assets.images.voucherItem1;
      case VoucherStatus.used:
        return Assets.images.voucherItem2;
      case VoucherStatus.expired:
        return Assets.images.voucherItem3;
    }
  }

  AssetGenImage _getCenterVoucherImage(VoucherStatus status) {
    switch (status) {
      case VoucherStatus.available:
        return Assets.images.centerVoucherPurchase;
      case VoucherStatus.used:
        return Assets.images.centerVoucherPurchase1;
      case VoucherStatus.expired:
        return Assets.images.centerVoucherPurchase1;
    }
  }

  Color _getButtonColor(VoucherStatus status) {
    switch (status) {
      case VoucherStatus.available:
        return Colors.red;
      case VoucherStatus.used:
        return AppColors.neutral04;
      case VoucherStatus.expired:
        return AppColors.neutral05;
    }
  }

  String _getButtonLabel(VoucherStatus status) {
    switch (status) {
      case VoucherStatus.available:
        return "Dùng ngay";
      case VoucherStatus.used:
        return "Đã dùng";
      case VoucherStatus.expired:
        return "Hết hạn";
    }
  }
}
