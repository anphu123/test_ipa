// import 'dart:async';
// import 'package:fido_box_demo01/modules/home/widgets/fido_box_product_banner/product_item_fido.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'mock_data_fido.dart';
// class AutoSwitchFeaturedBanner extends StatefulWidget {
//   const AutoSwitchFeaturedBanner({super.key});
//
//   @override
//   State<AutoSwitchFeaturedBanner> createState() =>
//       _AutoSwitchFeaturedBannerState();
// }
//
// class _AutoSwitchFeaturedBannerState extends State<AutoSwitchFeaturedBanner> {
//   late PageController _pageController;
//   int _currentPage = 0;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _startAutoScroll();
//   }
//
//   void _startAutoScroll() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (_currentPage < featuredGroups.length - 1) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//       _pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 180.h,
//       child: PageView.builder(
//         controller: _pageController,
//         itemCount: featuredGroups.length,
//         itemBuilder: (context, index) {
//           final group = featuredGroups[index];
//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: _buildGroup(group),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildGroup(List<ProductItem> group) {
//     return Row(
//       children: [
//         // Big item
//         Expanded(
//           flex: 2,
//           child: _buildProductCard(group[0], isLarge: true),
//         ),
//         SizedBox(width: 12.w),
//         Expanded(
//           flex: 2,
//           child: Column(
//             children: [
//               Expanded(child: _buildProductCard(group[1], isLarge: false)),
//               SizedBox(height: 12.h),
//               Expanded(child: _buildProductCard(group[2], isLarge: false)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProductCard(ProductItem item, {required bool isLarge}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       clipBehavior: Clip.hardEdge,
//       child: Row(
//         children: [
//           Expanded(
//             flex: isLarge ? 3 : 2,
//             child: Image.network(
//               item.image,
//               fit: BoxFit.cover,
//               height: double.infinity,
//             ),
//           ),
//           if (isLarge) SizedBox(width: 8.w),
//           Expanded(
//             flex: isLarge ? 4 : 3,
//             child: Padding(
//               padding: EdgeInsets.all(8.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(4.r),
//                     ),
//                     child: Text(
//                       item.tag,
//                       style: TextStyle(
//                         fontSize: 10.sp,
//                         color: Colors.blueAccent,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     item.title,
//                     style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   if (item.price.isNotEmpty) ...[
//                     SizedBox(height: 4.h),
//                     Text(
//                       item.price,
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
