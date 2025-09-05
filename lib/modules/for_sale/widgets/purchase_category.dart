// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/theme/app_typography.dart';
// import '../controllers/purchase_category_controller.dart';
//
// class PurchaseCategory extends GetView<PurchaseCategoryController> {
//   final int categoryId;
//
//   const PurchaseCategory({super.key, required this.categoryId});
//
//   @override
//   Widget build(BuildContext context) {
//     // Instantiate the controller using GetView
//     final controller = Get.put(PurchaseCategoryController(categoryId: categoryId));
//
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Get.back(),
//         ),
//         title: Obx(() => Text(controller.selectedCategoryName, style: AppTypography.s16.bold)),
//       ),
//       body: Column(
//         children: [
//           // 🔍 Search bar
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//             child: Container(
//               height: 40.h,
//               padding: EdgeInsets.symmetric(horizontal: 12.w),
//               decoration: BoxDecoration(
//                 color: AppColors.neutral08,
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(Icons.search, color: Colors.grey),
//                   SizedBox(width: 8.w),
//                   Expanded(
//                     child: TextField(
//                       onChanged: (query) {
//                         controller.searchBrands(query);
//                       },
//                       decoration: InputDecoration(
//                         hintText: "Tìm kiếm thương hiệu...",
//                         hintStyle: AppTypography.s13.regular.withColor(AppColors.neutral04),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // 🔄 Selected parent category (optional)
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Row(
//               children: [
//                 Text(
//                   controller.selectedCategoryName,
//                   style: AppTypography.s13.bold.withColor(AppColors.primary01),
//                 ),
//                 Icon(
//                   Icons.chevron_right,
//                   size: 18.w,
//                   color: AppColors.primary01,
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 12.h),
//
//           // 📱 Left - Right Categories
//           Expanded(
//             child: Row(
//               children: [
//                 // LEFT CATEGORY MENU
//                 Container(
//                   width: 120.w,
//                   color: AppColors.neutral08,
//                   child: ListView.builder(
//                     itemCount: controller.categories.length,
//                     itemBuilder: (context, index) {
//                       final isSelected = controller.categories[index].id == controller.categoryId.value;
//                       return GestureDetector(
//                         onTap: () {
//                           controller.categoryId.value = controller.categories[index].id;
//                         },
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                             vertical: 14.h,
//                             horizontal: 8.w,
//                           ),
//                           color: isSelected ? AppColors.white : Colors.transparent,
//                           child: Text(
//                             controller.categories[index].name,
//                             style: isSelected
//                                 ? AppTypography.s13.bold
//                                 : AppTypography.s13.regular,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//
//                 // RIGHT BRAND GRID
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.w),
//                     child: Obx(
//                           () {
//                         final filteredBrands = controller.filteredBrands;
//
//                         return ListView.builder(
//                           itemCount: filteredBrands.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: EdgeInsets.symmetric(vertical: 8.h),
//                               child: Text(
//                                 filteredBrands[index].name,
//                                 style: AppTypography.s14.medium,
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
