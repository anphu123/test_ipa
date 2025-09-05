// lib/modules/voucher_purchase/widgets/voucher_congrat_dialog.dart
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/voucher_purchase/widgets/hub_coupon/voucher_item_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/assets.gen.dart';

class VoucherCongratDialog extends StatefulWidget {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => VoucherCongratDialog(),
    );
  }

  @override
  _VoucherCongratDialogState createState() => _VoucherCongratDialogState();
}

class _VoucherCongratDialogState extends State<VoucherCongratDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _titleAnimation;
  late Animation<double> _voucherItem1Animation;
  late Animation<double> _voucherItem2Animation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _backgroundAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.3, curve: Curves.easeOut)),
    );
    _titleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.2, 0.5, curve: Curves.easeOut)),
    );
    _voucherItem1Animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.4, 0.7, curve: Curves.easeOut)),
    );
    _voucherItem2Animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 0.8, curve: Curves.easeOut)),
    );
    _buttonAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.7, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Container(
        height: 340.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            _buildBackground(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _backgroundAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.primary01,
              image: DecorationImage(
                image: AssetImage(Assets.images.bgVoucherPurchase.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          SizedBox(height: 16),
          _buildVoucherItem(_voucherItem1Animation),
          _buildVoucherItem(_voucherItem2Animation),
          SizedBox(height: 16),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Stack(
      children: [
        Center(
          child: AnimatedBuilder(
            animation: _titleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _titleAnimation.value,
                child: Text(
                  'Chúc mừng\nBạn đã nhận được voucher',
                  textAlign: TextAlign.center,
                  style: AppTypography.s16.semibold.withColor(AppColors.neutral01),
                ),
              );
            },
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.close, color: AppColors.neutral03),
          ),
        ),
      ],
    );
  }

  Widget _buildVoucherItem(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - animation.value)),
          child: Opacity(
            opacity: animation.value,
            child: VoucherItemDialog(
              value: "500k",
              condition: "Đơn từ ₫5.000.000",
              label: "Ưu đãi tốt nhất",
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton() {
    return AnimatedBuilder(
      animation: _buttonAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _buttonAnimation.value,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              height: 42.h,
              decoration: BoxDecoration(
                color: AppColors.primary01,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  'Thu thập',
                  style: AppTypography.s16.semibold.withColor(AppColors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
