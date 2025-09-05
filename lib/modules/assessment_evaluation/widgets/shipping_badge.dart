import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class ShippingBadge extends StatefulWidget {
  const ShippingBadge({super.key});

  @override
  State<ShippingBadge> createState() => _ShippingBadgeState();
}

class _ShippingBadgeState extends State<ShippingBadge> {
  final ScrollController _scrollController = ScrollController();
  late double _scrollPosition;
  late double _minScrollExtent;

  @override
  void initState() {
    super.initState();
    _scrollPosition = 0.0;
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScroll());
  }

  void _startAutoScroll() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (!_scrollController.hasClients) continue;

      _scrollPosition -= 1;

      // Nếu scroll đến đầu, nhảy về cuối để cuộn tiếp
      if (_scrollPosition <= _scrollController.position.minScrollExtent) {
        _scrollPosition = _scrollController.position.maxScrollExtent;
        _scrollController.jumpTo(_scrollPosition);
      } else {
        _scrollController.jumpTo(_scrollPosition);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = List.generate(6, (_) => _buildItem()).toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.AS02,
        borderRadius: BorderRadius.circular(4.r),
      ),
      height: 30.h,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(children: items),
      ),
    );
  }

  Widget _buildItem() {
    return Row(
      children: [
        // Icon(Icons.local_shipping, size: 16.sp, color: AppColors.AS01),
        Image.asset(Assets.images.icDanggiaohang.path, width: 16.w, height: 16.h, color: AppColors.AS01),
        SizedBox(width: 4.w),
        Text(
          LocaleKeys.free_shipping.trans(),
          style: AppTypography.s12.medium.copyWith(color: AppColors.AS01),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}
