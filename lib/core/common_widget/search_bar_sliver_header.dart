import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets/locale_keys.g.dart';
import '../common_widget/search_bar.dart';
import '../extensions/string_extension.dart';

class SearchBarSliverHeader extends SliverPersistentHeaderDelegate {
  final Color unpinnedColor;
  final Color pinnedColor;

  // ✅ Static để tránh bị reset mỗi lần build lại
  //static Color? _lastStatusBarColor;

  SearchBarSliverHeader({
    required this.unpinnedColor,
    required this.pinnedColor,
  });

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    final isPinned = shrinkOffset > 0;
    final Color currentColor = isPinned ? pinnedColor : unpinnedColor;

    // ✅ Đổi màu status bar nếu có thay đổi

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: isPinned ? 8 : 0,
          sigmaY: isPinned ? 8 : 0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 16.w,),

          decoration: BoxDecoration(
            color: currentColor.withOpacity(isPinned ? 0.9 : 0),
            boxShadow: isPinned
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ]
                : [],
          ),
          alignment: Alignment.center,
          child: CustomSearchBar(
            hintSuggestions: [
              LocaleKeys.latest_iphone.trans(),
              LocaleKeys.authentic_macbook.trans(),
              LocaleKeys.discounted_bluetooth_earbuds.trans(),
              LocaleKeys.authentic_apple_accessories.trans(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60.h;

  @override
  double get minExtent => 60.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
