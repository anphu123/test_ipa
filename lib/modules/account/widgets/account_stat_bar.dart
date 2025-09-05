// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../core/theme/app_typography.dart';
// import '../../../core/theme/app_colors.dart';
//
// class AccountStatBar extends StatelessWidget {
//   const AccountStatBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final PageController pageController = PageController();
//     final RxInt currentPage = 0.obs;
//
//     final items = [
//       {'label': 'Khuyến mãi', 'value': '5'},
//       {'label': 'Sưu tầm', 'value': '3'},
//       {'label': 'Yêu thích', 'value': '95'},
//       {'label': 'Giỏ hàng', 'value': '0'},
//       {'label': 'Đăng ký', 'value': '1'},
//     ];
//
//     final int itemsPerPage = 3;
//     final int pageCount = (items.length / itemsPerPage).ceil();
//
//     final List<List<Map<String, dynamic>>> pages = [];
//     for (int i = 0; i < items.length; i += itemsPerPage) {
//       final end =
//           (i + itemsPerPage < items.length) ? i + itemsPerPage : items.length;
//       pages.add(items.sublist(i, end));
//     }
//
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//       padding: EdgeInsets.symmetric(vertical: 16.h),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(8.r),
//         // boxShadow: [
//         //   BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
//         // ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 62.h,
//             child: PageView.builder(
//               controller: pageController,
//               itemCount: pageCount,
//               onPageChanged: (index) => currentPage.value = index,
//               itemBuilder: (context, pageIndex) {
//                 final pageItems = pages[pageIndex];
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(pageItems.length * 2 - 1, (i) {
//                     if (i.isOdd) {
//                       return Container(
//                         width: 0,
//                         height: 0.h,
//                         color: AppColors.neutral03.withOpacity(0.2),
//                       );
//                     }
//
//                     final item = pageItems[i ~/ 3];
//                     return Expanded(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             item['label'],
//                             style: AppTypography.s12.withColor(
//                               AppColors.neutral02,
//                             ),
//                             textAlign: TextAlign.center,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           SizedBox(height: 4.h),
//                           Text(
//                             item['value'].toString(),
//                             style: AppTypography.s14.bold.withColor(
//                               AppColors.neutral01,
//                             ),
//                           ),
//                           SizedBox(height: 2.h),
//
//                         ],
//                       ),
//                     );
//                   }),
//                 );
//               },
//             ),
//           ),
//       //    SizedBox(height: 12.h),
//           Obx(
//             () => Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 pageCount,
//                 (index) => AnimatedContainer(
//                   duration: const Duration(milliseconds: 250),
//                   margin: EdgeInsets.symmetric(horizontal: 3.w),
//                   width: currentPage.value == index ? 12.w : 8.w,
//                   height: 3.w,
//                   decoration: BoxDecoration(
//                     color:
//                         currentPage.value == index
//                             ? AppColors.primary
//                             : AppColors.neutral03.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';

class AccountStatBar extends StatelessWidget {
  const AccountStatBar({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Khuyến mãi', 'value': '5'},
      {'label': 'Sưu tầm', 'value': '3'},
      {'label': 'Yêu thích', 'value': '95'},
      {'label': 'Giỏ hàng', 'value': '0'},
      {'label': 'Đăng ký', 'value': '1'},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          return Expanded(
            child: Column(
              children: [
                Text(
                  item['label']!,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.s12.regular.withColor(AppColors.neutral02),
                ),
                SizedBox(height: 4.h),
                Text(
                  item['value']!,
                  style: AppTypography.s16.bold.withColor(AppColors.neutral02),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
