import 'package:fido_box_demo01/core/common_widget/search_bar.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../assets/locale_keys.g.dart';

class SearchBarSliverHeaderDetail extends SliverPersistentHeaderDelegate {
  final Color color;

  SearchBarSliverHeaderDetail({required this.color});

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back, size: 20.sp, color: Colors.black),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CustomSearchBar(
              hintSuggestions: [
                LocaleKeys.latest_iphone.trans(),
                LocaleKeys.authentic_macbook.trans(),
                LocaleKeys.discounted_bluetooth_earbuds.trans(),
                LocaleKeys.authentic_apple_accessories.trans(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 60.h;

  @override
  double get minExtent => 60.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}