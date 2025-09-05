import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/common_widget/currency_util.dart';
import '../../voucher_purchase/controllers/voucher_purchase_controller.dart';
import '../../voucher_purchase/domain/voucher_model.dart';
import '../controllers/assessment_evaluation_controller.dart';

class VoucherBottomSheet {
  static void show(BuildContext context) {
    final assessmentController = Get.find<AssessmentEvaluationController>();
    final voucherController = _getOrCreateVoucherController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      builder: (context) => _VoucherBottomSheetContent(
        assessmentController: assessmentController,
        voucherController: voucherController,
      ),
    );
  }

  static VoucherPurchaseController _getOrCreateVoucherController() {
    try {
      return Get.find<VoucherPurchaseController>();
    } catch (e) {
      return Get.put(VoucherPurchaseController());
    }
  }
}

class _VoucherBottomSheetContent extends StatelessWidget {
  final AssessmentEvaluationController assessmentController;
  final VoucherPurchaseController voucherController;

  const _VoucherBottomSheetContent({
    required this.assessmentController,
    required this.voucherController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandleBar(),
          _buildHeader(context),
          SizedBox(height: 16.h),
          Expanded(child: _buildVoucherList()),
        ],
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      width: 40.w,
      height: 4.h,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Trước: 'Chọn Voucher'
          Text(
            LocaleKeys.voucher_select_title.trans(),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherList() {
    return Obx(() {
      final vouchers = voucherController.availableVouchers;
      final currentPrice = assessmentController.result.evaluatedPrice;

      if (vouchers.isEmpty) {
        return _buildEmptyState();
      }

      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: vouchers.length + 1,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (_, index) => _buildVoucherListItem(index, vouchers, currentPrice),
      );
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.card_giftcard_outlined,
            size: 64.w,
            color: Colors.grey,
          ),
          SizedBox(height: 16.h),
          Text(
            LocaleKeys.voucher_empty_title.trans(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            LocaleKeys.voucher_empty_subtitle.trans(),
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherListItem(int index, List<VoucherModel> vouchers, int currentPrice) {
    if (index == 0) {
      return _buildNoVoucherOption(currentPrice);
    }

    final voucher = vouchers[index - 1];
    final isSelected = assessmentController.selectedVoucher.value?.id == voucher.id;
    final isApplicable = voucherController.isVoucherApplicable(voucher, currentPrice);

    return VoucherItem(
      voucher: voucher,
      isSelected: isSelected,
      isApplicable: isApplicable,
      currentPrice: currentPrice,
      voucherController: voucherController,
      onTap: () => _handleVoucherTap(voucher, isApplicable),
    );
  }

  Widget _buildNoVoucherOption(int currentPrice) {
    return VoucherItem(
      voucher: null,
      isSelected: assessmentController.selectedVoucher.value == null,
      isApplicable: true,
      currentPrice: currentPrice,
      voucherController: voucherController,
      onTap: _handleNoVoucherSelection,
    );
  }

  void _handleVoucherTap(VoucherModel voucher, bool isApplicable) {
    if (isApplicable) {
      _selectVoucher(voucher);
    } else {
      _showVoucherNotApplicableMessage(voucher);
    }
  }

  void _selectVoucher(VoucherModel voucher) {
    assessmentController.selectedVoucher.value = voucher;
    Get.back();
  }

  void _handleNoVoucherSelection() {
    assessmentController.selectedVoucher.value = null;
    Get.back();
  }

  void _showVoucherNotApplicableMessage(VoucherModel voucher) {
    Get.snackbar(
      'Không thể áp dụng',
      'Đơn hàng chưa đủ điều kiện tối thiểu ${voucher.condition}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }
}

class VoucherItem extends StatelessWidget {
  final VoucherModel? voucher;
  final bool isSelected;
  final bool isApplicable;
  final int currentPrice;
  final VoucherPurchaseController voucherController;
  final VoidCallback onTap;

  const VoucherItem({
    super.key,
    required this.voucher,
    required this.isSelected,
    required this.isApplicable,
    required this.currentPrice,
    required this.voucherController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: _buildItemDecoration(),
        child: Row(
          children: [
            _buildVoucherIcon(),
            SizedBox(width: 12.w),
            _buildVoucherDetails(),
            _buildSelectionIndicator(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildItemDecoration() {
    Color borderColor = Colors.grey.shade300;
    Color backgroundColor = Colors.white;

    if (isSelected) {
      borderColor = const Color(0xFF007AFF); // Hardcode primary color
      backgroundColor = const Color(0xFF007AFF).withOpacity(0.1);
    } else if (!isApplicable && voucher != null) {
      borderColor = Colors.red.shade300;
      backgroundColor = Colors.red.shade50;
    }

    return BoxDecoration(
      border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
      borderRadius: BorderRadius.circular(12.r),
      color: backgroundColor,
    );
  }

  Widget _buildVoucherIcon() {
    IconData iconData = Icons.card_giftcard;
    Color iconColor = const Color(0xFF007AFF);
    Color backgroundColor = const Color(0xFF007AFF).withOpacity(0.2);

    if (voucher == null) {
      iconData = Icons.block;
      iconColor = Colors.grey;
      backgroundColor = Colors.grey.shade200;
    } else if (!isApplicable) {
      iconData = Icons.lock;
      iconColor = Colors.red;
      backgroundColor = Colors.red.shade100;
    }

    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(iconData, color: iconColor, size: 24.w),
    );
  }

  Widget _buildVoucherDetails() {
    final discountAmount = voucher != null
        ? voucherController.calculateDiscount(voucher!, currentPrice)
        : 0;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  voucher?.amount ?? LocaleKeys.voucher_none_label.trans(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: voucher == null
                        ? Colors.grey
                        : !isApplicable
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ),
              if (voucher != null && isApplicable && discountAmount > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    '+${formatCurrency(discountAmount)}',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 4.h),
          if (voucher != null) ...[
            Text(
              '${LocaleKeys.voucher_min_order.trans()} ${voucher!.condition}',
              style: TextStyle(
                fontSize: 12.sp,
                color: !isApplicable ? Colors.red : Colors.grey.shade600,
              ),
            ),
            if (!isApplicable) ...[
              SizedBox(height: 2.h),
              Text(
                '${LocaleKeys.voucher_missing_amount.trans()} ${formatCurrency(_getRequiredAmount())}',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ],
          ] else
            Text(
            LocaleKeys.voucher_no_voucher_desc.trans(),
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectionIndicator() {
    if (isSelected) {
      return Icon(Icons.check_circle, color: const Color(0xFF007AFF), size: 24.w);
    } else if (voucher != null && !isApplicable) {
      return Icon(Icons.lock, color: Colors.red, size: 24.w);
    } else {
      return Icon(Icons.radio_button_unchecked, color: Colors.grey.shade400, size: 24.w);
    }
  }

  int _getRequiredAmount() {
    final conditionStr = voucher!.condition?.replaceAll(RegExp(r'[^\d]'), '') ?? '0';
    final minAmount = int.tryParse(conditionStr) ?? 0;
    return minAmount - currentPrice;
  }
}