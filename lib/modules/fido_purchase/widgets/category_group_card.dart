import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../router/app_page.dart';

class CategoryGroupCard extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final Color gradientStart;
  final Color gradientEnd;
  final Color backgroundItem;
  final BorderRadius? borderRadius;
  final BorderRadius? borderRadiusItem;
  final Function(int)? onItemTap;

  const CategoryGroupCard({
    super.key,
    required this.title,
    this.borderRadiusItem,
    required this.backgroundItem,
    required this.items,
    required this.gradientStart,
    required this.gradientEnd,
    this.borderRadius,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final rows = _chunkItems(items, 4);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gradient trái
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: borderRadius ?? BorderRadius.zero,
                  gradient: LinearGradient(
                    colors: [gradientStart, gradientEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.s14.bold.withColor(AppColors.white),
                    ),
                    SizedBox(height: 8.h),
                    Icon(Icons.arrow_forward, size: 20.sp, color: Colors.white),
                  ],
                ),
              ),
            ),

            // Nội dung phải
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadiusItem ?? BorderRadius.zero,
                  color: backgroundItem,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: rows
                        .map(
                          (row) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: _buildRowItems(row),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowItems(List<Map<String, dynamic>> rowItems) {
    return Row(
      children: rowItems.map((item) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              if (onItemTap != null && item['id'] != null) {
                onItemTap!(item['id']);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(item['image'], width: 35.w, height: 35.w),
                SizedBox(height: 4.h),
                Text(
                  item['label'],
                  style: AppTypography.s12.regular.withColor(
                    AppColors.neutral01,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  List<List<Map<String, dynamic>>> _chunkItems(
    List<Map<String, dynamic>> items,
    int size,
  ) {
    List<List<Map<String, dynamic>>> chunks = [];
    for (var i = 0; i < items.length; i += size) {
      chunks.add(
        items.sublist(i, i + size > items.length ? items.length : i + size),
      );
    }
    return chunks;
  }
}